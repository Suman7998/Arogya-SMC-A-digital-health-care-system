import { NextResponse } from 'next/server';
import { query } from '@/lib/db';

// GET /api/beneficiaries - Fetch all beneficiary families with their last visit date
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const wardCode = searchParams.get('ward_code');
    
    let queryStr = `
      SELECT b.*, 
             (SELECT MAX(visit_date) FROM visits v WHERE v.beneficiary_id = b.id) as last_visit
      FROM beneficiaries b 
    `;
    const params = [];
    
    if (wardCode) {
      queryStr += `WHERE b.ward_code = $1 `;
      params.push(wardCode);
    }
    
    queryStr += `ORDER BY b.created_at DESC`;
    
    const result = await query(queryStr, params);
    return NextResponse.json({
      success: true,
      data: result.rows
    });
  } catch (error: any) {
    console.error('Error fetching beneficiaries:', error);
    return NextResponse.json({ 
      success: false,
      error: 'Internal Server Error', 
      details: error.message 
    }, { status: 500 });
  }
}

// POST /api/beneficiaries - Add a new family
export async function POST(request: Request) {
  try {
    const data = await request.json();
    const { 
      id,
      family_name, 
      head_name, 
      ward_code, 
      address, 
      contact_number, 
      total_members, 
      pregnant_women_count, 
      children_count, 
      high_risk_flag 
    } = data;

    const result = await query(
      `INSERT INTO beneficiaries (
        family_name, head_name, ward_code, address, contact_number, 
        total_members, pregnant_women_count, children_count, high_risk_flag, client_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING *`,
      [
        family_name, head_name, ward_code, address, contact_number, 
        total_members || 1, pregnant_women_count || 0, children_count || 0, high_risk_flag || false,
        id || null
      ]
    );

    return NextResponse.json(result.rows[0], { status: 201 });
  } catch (error: any) {
    console.error('Error creating beneficiary:', error);
    return NextResponse.json({ error: 'Internal Server Error', details: error.message }, { status: 500 });
  }
}
