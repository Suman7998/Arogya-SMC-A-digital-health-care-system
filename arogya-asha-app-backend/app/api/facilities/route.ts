import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

// GET /api/facilities - Fetch all nearby healthcare facilities
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const ward = searchParams.get('ward');

    let result;
    if (ward) {
      result = await query(
        'SELECT * FROM facilities WHERE ward_code = $1 ORDER BY name ASC',
        [ward]
      );
    } else {
      result = await query('SELECT * FROM facilities ORDER BY name ASC');
    }

    return NextResponse.json(result.rows);
  } catch (error: any) {
    console.error('Error fetching facilities:', error);
    return NextResponse.json({ error: 'Internal Server Error', details: error.message }, { status: 500 });
  }
}
