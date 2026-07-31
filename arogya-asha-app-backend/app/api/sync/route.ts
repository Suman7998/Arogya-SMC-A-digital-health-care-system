// app/api/sync/route.ts (updated)
import { NextRequest, NextResponse } from 'next/server';
import pool from '@/lib/db';

export async function POST(request: NextRequest) {
  console.log('[sync] Sync request received');
  const body = await request.json();
  const { reports, families, children, visits, vaccinations, growth } = body;
  console.log(`[sync] Payload received: ${reports?.length || 0} reports, ${families?.length || 0} families, ${children?.length || 0} children, ${visits?.length || 0} visits`);

  const client = await pool.connect(); 
  try {
    await client.query('BEGIN');

    // 1. Process reports (asha_reports table)
    if (reports && reports.length) {
      for (const report of reports) {
        await client.query(
          `INSERT INTO asha_reports (
            client_id, worker_id, worker_name, ward_code, report_date, submission_time,
            fever_count, cough_count, diarrhea_count, jaundice_count, rash_count,
            disease_type, maternal_risk_flags, child_risk_flags, environmental_flags,
            location_lat, location_lng, photo_paths, sync_status
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)
          ON CONFLICT (client_id) DO NOTHING`,
          [
            report.id, report.workerId, report.workerName, report.wardCode,
            report.reportDate, report.submissionTime,
            report.feverCount, report.coughCount, report.diarrheaCount,
            report.jaundiceCount, report.rashCount,
            report.diseaseType,
            report.maternalRiskFlags, report.childRiskFlags, report.environmentalFlags,
            report.locationLat, report.locationLng, report.photoPaths,
            1 // sync_status = synced
          ]
        );
      }
      console.log(`[sync] Processed ${reports.length} reports`);
    }

    // 2. Process families (beneficiaries table)
    if (families && families.length) {
      for (const family of families) {
        await client.query(
          `INSERT INTO beneficiaries (
            client_id, family_name, head_name, ward_code, address, contact_number,
            total_members, pregnant_women_count, children_count, high_risk_flag
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
          ON CONFLICT (client_id) DO UPDATE SET
            family_name = EXCLUDED.family_name,
            head_name = EXCLUDED.head_name,
            address = EXCLUDED.address,
            contact_number = EXCLUDED.contact_number,
            total_members = EXCLUDED.total_members,
            pregnant_women_count = EXCLUDED.pregnant_women_count,
            children_count = EXCLUDED.children_count,
            high_risk_flag = EXCLUDED.high_risk_flag,
            updated_at = NOW()`,
          [
            family.id, family.familyName, family.headName, family.wardCode,
            family.address, family.contactNumber, family.totalMembers,
            family.pregnantWomenCount, family.childrenCount, family.highRiskFlag
          ]
        );
      }
      console.log(`[sync] Processed ${families.length} families`);
    }

    // 3. Process children
    if (children && children.length) {
      for (const child of children) {
        const familyIdInteger = await client.query(
          `SELECT id FROM beneficiaries WHERE client_id = $1`,
          [child.familyId]
        );

        if (familyIdInteger.rows.length === 0) {
          console.warn(`Family not found for child ${child.id}`);
          continue;
        }

        const actualFamilyId = familyIdInteger.rows[0].id;

        await client.query(
          `INSERT INTO children (client_id, family_id, name, date_of_birth, gender, blood_group, nutrition_status)
           VALUES ($1, $2, $3, $4, $5, $6, $7)
           ON CONFLICT (client_id) DO UPDATE SET
             name = EXCLUDED.name,
             date_of_birth = EXCLUDED.date_of_birth,
             gender = EXCLUDED.gender,
             blood_group = EXCLUDED.blood_group,
             nutrition_status = EXCLUDED.nutrition_status`,
          [child.id, actualFamilyId, child.name, child.dateOfBirth, child.gender, child.bloodGroup, child.nutritionStatus]
        );
      }
      console.log(`[sync] Processed ${children.length} children`);
    }

    // 4. Process visits
    if (visits && visits.length) {
      for (const visit of visits) {
        let actualBeneficiaryId = null;
        if (visit.beneficiaryId) {
          const benRes = await client.query(
            `SELECT id FROM beneficiaries WHERE client_id = $1`,
            [visit.beneficiaryId]
          );
          if (benRes.rows.length > 0) {
            actualBeneficiaryId = benRes.rows[0].id;
          } else {
             console.warn(`Beneficiary not found for visit ${visit.id}`);
             continue;
          }
        }

        await client.query(
          `INSERT INTO visits (
            client_id, beneficiary_id, visit_date, health_status, fever, cough, diarrhea,
            notes, follow_up_required, location_lat, location_lng, photo_path
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
          ON CONFLICT (client_id) DO NOTHING`,
          [
            visit.id, actualBeneficiaryId, visit.visitDate, visit.healthStatus,
            visit.fever, visit.cough, visit.diarrhea, visit.notes,
            visit.followUpRequired, visit.locationLat, visit.locationLng, visit.photoPath
          ]
        );
      }
      console.log(`[sync] Processed ${visits.length} visits`);
    }

    // 5. Process vaccinations
    if (vaccinations && vaccinations.length) {
      for (const vacc of vaccinations) {
        let actualChildId = null;
        if (vacc.childId) {
           const childRes = await client.query(
             `SELECT id FROM children WHERE client_id = $1`,
             [vacc.childId]
           );
           if (childRes.rows.length > 0) {
              actualChildId = childRes.rows[0].id;
           } else {
              console.warn(`Child not found for vaccination`);
              continue;
           }
        }

        await client.query(
          `INSERT INTO vaccinations (client_id, child_id, vaccine_name, dose_number, date_given, next_due_date, remarks)
           VALUES ($1, $2, $3, $4, $5, $6, $7)
           ON CONFLICT (client_id) DO NOTHING`,
          [vacc.id, actualChildId, vacc.vaccineName, vacc.doseNumber, vacc.dateGiven, vacc.nextDueDate, vacc.remarks]
        );
      }
      console.log(`[sync] Processed ${vaccinations.length} vaccinations`);
    }

    // 6. Process growth measurements
    if (growth && growth.length) {
      for (const m of growth) {
        let actualChildId = null;
        if (m.childId) {
          const childRes = await client.query(
            `SELECT id FROM children WHERE client_id = $1`,
            [m.childId]
          );
          if (childRes.rows.length > 0) {
            actualChildId = childRes.rows[0].id;
          } else {
            continue;
          }
        }

        await client.query(
          `INSERT INTO growth_measurements (
            client_id, child_id, measured_at, weight_kg, height_cm, age_months, nutrition_status, notes
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
          ON CONFLICT (client_id) DO NOTHING`,
          [m.id, actualChildId, m.measuredAt, m.weightKg, m.heightCm, m.ageMonths, m.nutritionStatus, m.notes]
        );
      }
      console.log(`[sync] Processed ${growth.length} growth measurements`);
    }

    await client.query('COMMIT');
    console.log('[sync] Sync completed successfully');
    return NextResponse.json({ success: true });
  } catch (error: any) {
    await client.query('ROLLBACK');
    console.error('[sync] Error executing sync transactions:', error.message, error.stack);
    return NextResponse.json({ success: false, error: 'Sync failed' }, { status: 500 });
  } finally {
    client.release();
  }
}