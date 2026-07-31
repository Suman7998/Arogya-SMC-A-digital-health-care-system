// app/api/beneficiaries/children/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function POST(request: NextRequest) {
  const body = await request.json();
  const { id, family_id, name, date_of_birth, gender, blood_group, nutrition_status } = body;

  console.log('[beneficiaries/children] POST request payload:', body);

  if (!id || !family_id || !name || !date_of_birth || !gender) {
    return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
  }

  try {
    // Resolve family UUID to internal ID
    const benRes = await query('SELECT id FROM beneficiaries WHERE client_id = $1', [family_id]);
    const actualFamilyId = benRes.rows.length > 0 ? benRes.rows[0].id : family_id;
    console.log(`[beneficiaries/children] Resolved family_id UUID ${family_id} to internal Postgres ID ${actualFamilyId}`);

    const result = await query(
      `INSERT INTO children (client_id, family_id, name, date_of_birth, gender, blood_group, nutrition_status)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       ON CONFLICT (client_id) DO UPDATE SET
         name = EXCLUDED.name,
         date_of_birth = EXCLUDED.date_of_birth,
         gender = EXCLUDED.gender,
         blood_group = EXCLUDED.blood_group,
         nutrition_status = EXCLUDED.nutrition_status
       RETURNING *`,
      [id, actualFamilyId, name, date_of_birth, gender, blood_group, nutrition_status || 'normal']
    );
    return NextResponse.json({ success: true, data: result.rows[0] }, { status: 201 });
  } catch (error: any) {
    console.error('[beneficiaries/children] Error:', error.message, error.stack);
    return NextResponse.json({ error: 'Database error' }, { status: 500 });
  }
}