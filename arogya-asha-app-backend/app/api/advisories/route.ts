// app/api/advisories/route.ts
import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET() {
  try {
    const result = await query(`
      SELECT id, title, description, severity, ward_code, published_at
      FROM advisories
      WHERE expires_at > NOW() OR expires_at IS NULL
      ORDER BY published_at DESC
    `);
    return NextResponse.json({ success: true, data: result.rows });
  } catch (error) {
    return NextResponse.json({ error: 'Failed to fetch advisories' }, { status: 500 });
  }
}