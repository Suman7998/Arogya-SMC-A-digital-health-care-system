import { NextResponse } from 'next/server';
import pool from '@/lib/db';
import { sendMulticast } from '@/lib/firebase';

const TRIGGER_SECRET = process.env.NOTIFICATION_TRIGGER_SECRET; // e.g., a random string

export async function POST(request: Request) {
  try {
    const { secret, type, recordId, title, body } = await request.json();
    if (secret !== TRIGGER_SECRET) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Fetch device tokens (e.g., for all CMO/Deputy-CMO, or for citizens based on ward)
    const tokensRes = await pool.query(`
      SELECT dt.token FROM device_tokens dt
      JOIN users u ON dt.user_id = u.id
      WHERE u.role IN ('CMO', 'Deputy-CMO', 'Nagar-Swasthya')
    `);
    const tokens = tokensRes.rows.map(r => r.token);

    if (tokens.length === 0) {
      return NextResponse.json({ success: false, message: 'No tokens' });
    }

    // Send notification
    await sendMulticast(tokens, title, body, { type, recordId: recordId?.toString() });

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Notification trigger error:', error);
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}