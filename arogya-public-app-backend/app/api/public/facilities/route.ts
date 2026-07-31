import pool from "@/lib/db";

export async function GET() {
  const query = `
    SELECT
      f.id,
      f.name,
      f.ward_code,
      f.address,
      f.contact,
      f.type,
      f.specialties,
      f.location_lat,
      f.location_lng,
      COALESCE(cr.beds_total, 0) AS beds_total,
      COALESCE(cr.beds_available, 0) AS beds_available,
      COALESCE(cr.icu_total, 0) AS icu_total,
      (COALESCE(cr.icu_available, 0) > 0) AS icu_available,
      COALESCE(cr.ventilators_total, 0) AS ventilators_total,
      (COALESCE(cr.ventilators_available, 0) > 0) AS ventilators_available,
      COALESCE(cr.oxygen_available, false) AS oxygen_available,
      cr.report_date AS last_updated
    FROM facilities f
    LEFT JOIN LATERAL (
      SELECT *
      FROM capacity_reports
      WHERE facility_id = f.id
      ORDER BY report_date DESC
      LIMIT 1
    ) cr ON true
    ORDER BY f.name
  `;

  try {
    const result = await pool.query(query);
    return Response.json(result.rows);
  } catch (error) {
    console.error('Facilities API error:', error);
    return Response.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}