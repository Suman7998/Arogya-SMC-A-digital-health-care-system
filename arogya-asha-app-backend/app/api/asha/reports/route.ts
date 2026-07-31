import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function POST(request: NextRequest) {
  console.log('[asha/reports] Request received');
  try {
    const data = await request.json();
    console.log('[asha/reports] Data:', data);
    const { id, disease_type, ...restData } = data;
    
    if (!data.worker_id || !data.ward_code || !data.report_date) {
      return NextResponse.json({ success: false, error: 'Missing mandatory fields' }, { status: 400 });
    }

    const result = await query(`
      INSERT INTO asha_reports (
        worker_id, worker_name, ward_code, report_date,
        fever_count, cough_count, diarrhea_count, jaundice_count, rash_count,
        pregnant_women_count, high_risk_pregnancy_count, anc_visits_conducted,
        children_under_5_count, malnourished_children,
        stagnant_water, poor_sanitation, garbage_dumping, mosquito_breeding,
        location_lat, location_lng, disease_type, sync_status, client_id
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, 'synced', $22
      ) RETURNING id`, 
      [
        data.worker_id, data.worker_name || 'Anonymous', data.ward_code, data.report_date,
        data.fever_count || 0, data.cough_count || 0, data.diarrhea_count || 0, data.jaundice_count || 0, data.rash_count || 0,
        data.pregnant_women_count || 0, data.high_risk_pregnancy_count || 0, data.anc_visits_conducted || 0,
        data.children_under_5_count || 0, data.malnourished_children || 0,
        data.stagnant_water || false, data.poor_sanitation || false, data.garbage_dumping || false, data.mosquito_breeding || false,
        data.location_lat || 0, data.location_lng || 0, disease_type || null, id || null
      ]
    );

    const reportId = result.rows[0].id;

    // 1. Log to Audit Table
    await query(
      `INSERT INTO audit_logs (user_id, table_name, record_id, action) 
       VALUES ($1, 'asha_reports', $2, 'create_report')`,
      [data.worker_id, reportId]
    );

    // 2. Outbreak Detection Logic (Alerts Table)
    if ((data.fever_count || 0) > 5) {
      await query(
        `INSERT INTO alerts (type, severity, ward_code, title, description)
         VALUES ('outbreak', 'high', $1, 'Fever Spike Detected', $2)`,
        [data.ward_code, `ASHA ${data.worker_name} reported ${data.fever_count} fever cases in ${data.ward_code}. Potential outbreak investigation required.`]
      );
    }

    console.log('[asha/reports] Insert successful, report id:', reportId);
    return NextResponse.json({
      success: true,
      data: { report_id: reportId },
      message: 'Report serialized and stored in PostgreSQL successfully'
    });
  } catch (error: any) {
    console.error('[asha/reports] Error:', error.message, error.stack);
    return NextResponse.json({ success: false, error: 'Database Error: ' + error.message }, { status: 500 });
  }
}
