// app/api/facilities/nearby/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { query } from '@/lib/db';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const lat = parseFloat(searchParams.get('lat') || '0');
  const lng = parseFloat(searchParams.get('lng') || '0');
  const radius = parseFloat(searchParams.get('radius') || '5000'); // meters
  console.log(`[facilities/nearby] Request received for lat: ${lat}, lng: ${lng}, radius: ${radius}`);

  if (isNaN(lat) || isNaN(lng)) {
    return NextResponse.json({ error: 'Invalid coordinates' }, { status: 400 });
  }

  try {
    const result = await query(`
      SELECT id, name, facility_type, address, contact_number,
             ST_Distance(geom, ST_SetSRID(ST_MakePoint($2, $1), 4326)) AS distance
      FROM facilities
      WHERE ST_DWithin(geom, ST_SetSRID(ST_MakePoint($2, $1), 4326), $3)
      ORDER BY distance
      LIMIT 20
    `, [lat, lng, radius]);

    console.log(`[facilities/nearby] Found ${result.rows.length} facilities within ${radius}m limit`);
    return NextResponse.json({ success: true, data: result.rows });
  } catch (error: any) {
    console.error('[facilities/nearby] Error:', error.message, error.stack);
    return NextResponse.json({ error: 'Database error' }, { status: 500 });
  }
}