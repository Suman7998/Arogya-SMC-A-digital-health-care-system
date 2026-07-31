import pool from "@/lib/db";

export async function GET() {
  const query = `
    SELECT
      id,
      title,
      description,
      severity,
      type,
      ward_code,
      generated_at,
      status
    FROM alerts
    WHERE status = 'active' OR status IS NULL
    ORDER BY generated_at DESC
  `;

  try {
    const result = await pool.query(query);
    return Response.json(result.rows);
  } catch (error) {
    console.error('Alerts API error:', error);
    return Response.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}