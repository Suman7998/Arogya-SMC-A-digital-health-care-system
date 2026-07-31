import { NextRequest, NextResponse } from 'next/server';
import pool from '@/lib/db';

export async function POST(request: NextRequest) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    const data = await request.json();
    const {
      beneficiary_id,
      name,
      age,
      gender,
      health_status,
      pregnancy_status,
      is_child,
      date_of_birth,
      blood_group,
      nutrition_status
    } = data;

    // Validation
    if (!beneficiary_id || !name || age === undefined || age < 0) {
      return NextResponse.json({ success: false, error: 'Missing or invalid required fields' }, { status: 400 });
    }
    if (gender && !['Male', 'Female', 'Other'].includes(gender)) {
      return NextResponse.json({ success: false, error: 'Invalid gender' }, { status: 400 });
    }
    if (is_child && (!date_of_birth || new Date(date_of_birth) > new Date())) {
      return NextResponse.json({ success: false, error: 'Invalid date of birth for child' }, { status: 400 });
    }

    // Insert family member
    const memberResult = await client.query(
      `INSERT INTO family_members (
        beneficiary_id, name, age, gender, health_status, pregnancy_status
      ) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id`,
      [beneficiary_id, name, age, gender, health_status || 'Normal', pregnancy_status || 'No']
    );
    const memberId = memberResult.rows[0].id;

    let childId = null;
    if (is_child) {
      const childResult = await client.query(
        `INSERT INTO children (
          beneficiary_id, family_member_id, name, date_of_birth, gender, blood_group, nutrition_status
        ) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id`,
        [beneficiary_id, memberId, name, date_of_birth, gender, blood_group || null, nutrition_status || 'Normal']
      );
      childId = childResult.rows[0].id;
    }

    // Update total members
    await client.query(
      'UPDATE beneficiaries SET total_members = total_members + 1 WHERE id = $1',
      [beneficiary_id]
    );

    await client.query('COMMIT');

    return NextResponse.json({
      success: true,
      data: { 
        member_id: memberId, 
        child_id: childId,
        message: 'Member added successfully'
      }
    }, { status: 201 });
  } catch (error: any) {
    await client.query('ROLLBACK');
    console.error('Error adding family member:', error);
    return NextResponse.json({ success: false, error: 'Database error: ' + error.message }, { status: 500 });
  } finally {
    client.release();
  }
}

