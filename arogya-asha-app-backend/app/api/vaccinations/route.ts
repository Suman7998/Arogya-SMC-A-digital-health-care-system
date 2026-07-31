import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const childId = searchParams.get('child_id');

    if (!childId) {
      return NextResponse.json({ error: 'child_id is required' }, { status: 400 });
    }

    const result = await query(
      'SELECT * FROM vaccinations WHERE child_id = $1 ORDER BY date_given DESC',
      [childId]
    );

    return NextResponse.json(result.rows);
  } catch (error: any) {
    console.error('[API Error]', { path: request.url, method: request.method, error: error.message, stack: error.stack });
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function POST(request: Request) {
  try {
    const data = await request.json();
    const { 
      id,
      child_id, 
      vaccine_name, 
      dose_number, 
      date_given, 
      next_due_date, 
      remarks 
    } = data;

    const childRes = await query('SELECT id FROM children WHERE client_id = $1', [child_id]);
    const actualChildId = childRes.rows.length > 0 ? childRes.rows[0].id : child_id;

    const result = await query(
      `INSERT INTO vaccinations (
        child_id, vaccine_name, dose_number, date_given, next_due_date, remarks, client_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [
        actualChildId, 
        vaccine_name, 
        dose_number || 1, 
        date_given || new Date().toISOString().split('T')[0], 
        next_due_date, 
        remarks || '',
        id || null
      ]
    );

    return NextResponse.json(result.rows[0], { status: 201 });
  } catch (error: any) {
    console.error('[API Error]', { path: request.url, method: request.method, error: error.message, stack: error.stack });
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
