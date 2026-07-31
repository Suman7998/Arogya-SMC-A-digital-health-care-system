import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function POST(request: Request) {
  try {
const data = await request.json();
    const { disease_type, ...restData } = data;

    // Required fields
    const { 
      worker_id, 
      ward_code, 
      report_date,
      fever_count,
      cough_count,
      diarrhea_count,
      jaundice_count,
      rash_count,
      maternal_risk_flags,
      child_risk_flags,
      environmental_flags,
      location_lat,
      location_lng,
      photo_paths
    } = data;

    if (!worker_id || !ward_code || !report_date) {
      return NextResponse.json(
        { success: false, error: 'Missing mandatory fields' },
        { status: 400 }
      );
    }

    const result = await query(
      `INSERT INTO asha_reports (
        worker_id, ward_code, report_date,
        fever_count, cough_count, diarrhea_count, jaundice_count, rash_count,
        maternal_risk_flags, child_risk_flags, environmental_flags,
        location_lat, location_lng, disease_type, photo_paths
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15
      ) RETURNING id`,
      [
        worker_id,
        ward_code,
        report_date,
        fever_count || 0,
        cough_count || 0,
        diarrhea_count || 0,
        jaundice_count || 0,
        rash_count || 0,
        maternal_risk_flags || {},
        child_risk_flags || {},
        environmental_flags || {},
        location_lat || null,
        location_lng || null,
        disease_type || null,
        photo_paths || []
      ]
    );

    const reportId = result.rows[0].id;

    // Optionally log to audit log
    await query(
      `INSERT INTO system_audit_logs (user_id, action_type, description) 
       VALUES ($1, 'create_report', $2)`,
      [worker_id, `Report ${reportId} created`]
    );

    // Outbreak detection (example)
    if ((fever_count || 0) > 5) {
      await query(
        `INSERT INTO alerts (type, severity, ward_code, title, description)
         VALUES ('outbreak', 'high', $1, 'Fever Spike Detected', $2)`,
        [ward_code, `ASHA worker ${worker_id} reported ${fever_count} fever cases in ${ward_code}.`]
      );
    }

    return NextResponse.json({
      success: true,
      data: { report_id: reportId },
      message: 'Report stored successfully'
    });
  } catch (error: any) {
    console.error('Submission Error:', error.message);
    return NextResponse.json(
      { success: false, error: 'Database Error: ' + error.message },
      { status: 500 }
    );
  }
}