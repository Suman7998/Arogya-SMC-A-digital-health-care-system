import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET() {
  try {
    const result = await query(`
      SELECT code, name, total_population 
      FROM wards 
      WHERE code LIKE 'W%' 
      ORDER BY code ASC
    `);
    
    return NextResponse.json({
      success: true,
      data: result.rows
    });
  } catch (error: any) {
    console.error('Error fetching wards:', error);
    return NextResponse.json({ 
      success: false, 
      error: 'Failed to fetch wards',
      details: error.message 
    }, { status: 500 });
  }
}
