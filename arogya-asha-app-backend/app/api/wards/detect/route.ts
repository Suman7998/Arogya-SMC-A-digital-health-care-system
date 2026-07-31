import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const lat = searchParams.get('lat');
  const lng = searchParams.get('lng');

  if (!lat || !lng) {
    return NextResponse.json(
      { error: 'Missing lat or lng parameters' },
      { status: 400 }
    );
  }

  try {
    // Convert to numbers and ensure they are valid
    const latitude = parseFloat(lat);
    const longitude = parseFloat(lng);
    if (isNaN(latitude) || isNaN(longitude)) {
      return NextResponse.json(
        { error: 'Invalid lat/lng values' },
        { status: 400 }
      );
    }

    // Query using PostGIS
    const result = await query(
      `SELECT code, name FROM wards 
       WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint($1, $2), 4326))
       LIMIT 1`,
      [longitude, latitude]  // Note: ST_MakePoint expects lng, lat
    );

    if (result.rows.length === 0) {
      return NextResponse.json(
        { error: 'No ward found for these coordinates' },
        { status: 404 }
      );
    }

    return NextResponse.json({
      success: true,
      data: {
        ward_code: result.rows[0].code,
        ward_name: result.rows[0].name,
      },
    });
  } catch (error) {
    console.error('Ward detection error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}