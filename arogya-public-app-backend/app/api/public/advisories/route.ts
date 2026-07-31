import pool from "@/lib/db";

export async function GET() {
  const query = `
    SELECT
      id,
      title,
      description,
      severity,
      ward_code,
      published_at
    FROM advisories
    WHERE (expires_at IS NULL OR expires_at > NOW())
    ORDER BY published_at DESC
  `;

  try {
    const result = await pool.query(query);
    return Response.json(result.rows);
  } catch (error) {
    console.error('Advisories API error:', error);
    return Response.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}