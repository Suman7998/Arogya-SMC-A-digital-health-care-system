import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET() {
  try {
    const result = await query(`
      SELECT code, name, name_marathi, population 
      FROM wards 
      ORDER BY name ASC
    `);
    
    return NextResponse.json({
      success: true,
      data: result.rows
    });
  } catch (error: any) {
    return NextResponse.json({ success: false, error: error.message }, { status: 500 });
  }
}
