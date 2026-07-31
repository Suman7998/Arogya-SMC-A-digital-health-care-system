import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const lang = searchParams.get('lang') || 'en';

  try {
    const result = await query(`
      SELECT id, title, description, severity, ward_code, published_at
      FROM advisories
      WHERE is_active = true 
      ORDER BY published_at DESC
    `);

    return NextResponse.json(result.rows);
  } catch (error) {
    return NextResponse.json(
      { error: 'Postgres Query Failed. Check if tables exist in pgAdmin.' },
      { status: 500 }
    );
  }
}
