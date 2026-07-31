import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const childId = searchParams.get('child_id');

    if (!childId) {
      return NextResponse.json({ success: false, error: 'child_id is required' }, { status: 400 });
    }

    const result = await query(
      `SELECT * FROM growth_measurements 
       WHERE child_id = $1 
       ORDER BY measured_at DESC, id DESC`,
      [childId]
    );

    return NextResponse.json({
      success: true,
      data: result.rows
    });
  } catch (error: any) {
    console.error('[API Error]', { path: request.url, method: request.method, error: error.message, stack: error.stack });
    return NextResponse.json({ success: false, error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    const { 
      id,
      child_id,
      measured_at,
      weight_kg,
      height_cm,
      age_months,
      nutrition_status,
      notes
    } = data;

    if (!child_id || weight_kg === undefined || weight_kg <= 0 || height_cm === undefined || height_cm <= 0) {
      return NextResponse.json({ success: false, error: 'Invalid input data' }, { status: 400 });
    }

    const childRes = await query('SELECT id FROM children WHERE client_id = $1', [child_id]);
    const actualChildId = childRes.rows.length > 0 ? childRes.rows[0].id : child_id;

    const result = await query(
      `INSERT INTO growth_measurements (
        child_id, measured_at, weight_kg, height_cm, age_months, nutrition_status, notes, client_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [
        actualChildId,
        measured_at || new Date().toISOString().split('T')[0],
        weight_kg,
        height_cm,
        age_months || null,
        nutrition_status || 'normal',
        notes || '',
        id || null
      ]
    );

    if (nutrition_status) {
      await query(
        'UPDATE children SET nutrition_status = $1 WHERE id = $2',
        [nutrition_status, actualChildId]
      );
    }

    return NextResponse.json({
      success: true,
      data: result.rows[0]
    }, { status: 201 });
  } catch (error: any) {
    console.error('[API Error]', { path: request.url, method: request.method, error: error.message, stack: error.stack });
    return NextResponse.json({ success: false, error: 'Internal Server Error' }, { status: 500 });
  }
}
