import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const beneficiaryId = parseInt(params.id);
    if (isNaN(beneficiaryId)) {
      return NextResponse.json({ success: false, error: 'Invalid beneficiary ID' }, { status: 400 });
    }

    const result = await query(`
      SELECT 
        b.*,
        COALESCE(
          jsonb_agg(
            jsonb_build_object(
              'id', fm.id,
              'name', fm.name,
              'age', fm.age,
              'gender', fm.gender,
              'health_status', fm.health_status,
              'pregnancy_status', fm.pregnancy_status,
              'is_child', (c.id IS NOT NULL),
              'child_details', jsonb_build_object(
                'id', c.id,
                'date_of_birth', c.date_of_birth,
                'blood_group', c.blood_group,
                'nutrition_status', c.nutrition_status
              ),
              'growth_measurements', (
                SELECT COALESCE(jsonb_agg(
                  jsonb_build_object(
                    'id', gm.id,
                    'measured_at', gm.measured_at,
                    'weight_kg', gm.weight_kg,
                    'height_cm', gm.height_cm,
                    'age_months', gm.age_months,
                    'nutrition_status', gm.nutrition_status,
                    'notes', gm.notes
                  ) ORDER BY gm.measured_at DESC, gm.id DESC
                ), '[]'::jsonb)
                FROM growth_measurements gm
                WHERE gm.child_id = c.id
              ),
              'vaccinations', (
                SELECT COALESCE(jsonb_agg(
                  jsonb_build_object(
                    'id', v.id,
                    'vaccine_name', v.vaccine_name,
                    'dose_number', v.dose_number,
                    'date_given', v.date_given,
                    'next_due_date', v.next_due_date,
                    'remarks', v.remarks
                  ) ORDER BY v.date_given DESC, v.id DESC
                ), '[]'::jsonb)
                FROM vaccinations v
                WHERE v.child_id = c.id
              )
            ) FILTER (WHERE fm.id IS NOT NULL)
          ), '[]'::jsonb
        ) as members
      FROM beneficiaries b
      LEFT JOIN family_members fm ON b.id = fm.beneficiary_id
      LEFT JOIN children c ON fm.id = c.family_member_id
      WHERE b.id = $1
      GROUP BY b.id
    `, [beneficiaryId]);

    if (result.rows.length === 0) {
      return NextResponse.json({ success: false, error: 'Beneficiary not found' }, { status: 404 });
    }

    return NextResponse.json({
      success: true,
      data: result.rows[0]
    });
  } catch (error: any) {
    console.error('Error fetching beneficiary details:', error);
    return NextResponse.json({ 
      success: false, 
      error: 'Internal Server Error',
      details: error.message 
    }, { status: 500 });
  }
}

