import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET() {
  try {
    const result = await query(`
      SELECT f.*, w.name as ward_name 
      FROM facilities f 
      JOIN wards w ON f.ward_code = w.code 
      ORDER BY f.name ASC
    `);

    return NextResponse.json({
      success: true,
      data: result.rows
    });
  } catch (error: any) {
    return NextResponse.json({
      success: false,
      error: 'Connection failed. Ensure PostgreSQL 18 is running and .env.local is correct.'
    }, { status: 500 });
  }
}
