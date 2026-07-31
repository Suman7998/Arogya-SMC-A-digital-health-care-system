import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const beneficiaryId = searchParams.get('beneficiary_id');

    if (!beneficiaryId) {
      return NextResponse.json({ error: 'beneficiary_id is required' }, { status: 400 });
    }

    const result = await query(
      'SELECT * FROM visits WHERE beneficiary_id = $1 ORDER BY visit_date DESC',
      [beneficiaryId]
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
      beneficiary_id, 
      visit_date, 
      health_status, 
      fever, 
      cough, 
      diarrhea, 
      notes, 
      follow_up_required 
    } = data;

    // Resolve parent UUID to internal ID
    const benRes = await query('SELECT id FROM beneficiaries WHERE client_id = $1', [beneficiary_id]);
    const actualBeneficiaryId = benRes.rows.length > 0 ? benRes.rows[0].id : beneficiary_id;

    const result = await query(
      `INSERT INTO visits (
        beneficiary_id, visit_date, health_status, fever, cough, diarrhea, notes, follow_up_required, client_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *`,
      [
        actualBeneficiaryId, 
        visit_date || new Date().toISOString().split('T')[0], 
        health_status || 'Normal', 
        fever || false, 
        cough || false, 
        diarrhea || false, 
        notes || '', 
        follow_up_required || false,
        id || null
      ]
    );

    return NextResponse.json(result.rows[0], { status: 201 });
  } catch (error: any) {
    console.error('[API Error]', { path: request.url, method: request.method, error: error.message, stack: error.stack });
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
