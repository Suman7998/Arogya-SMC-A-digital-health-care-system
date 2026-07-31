import { NextResponse } from 'next/server';

export async function GET() {
  const alerts = [
    {
      id: 1,
      type: 'HEALTH ALERT',
      severity: 'high',
      title: 'Polio Vaccination Drive',
      description: 'The vaccination drive starts this Sunday at ward centers.',
      generated_at: new Date().toISOString(),
      status: 'active',
      is_read: false
    },
    {
      id: 2,
      type: 'ADVISORY',
      severity: 'medium',
      title: 'Monsoon Precautions',
      description: 'Please advise beneficiaries about boiling water during monsoon.',
      generated_at: new Date().toISOString(),
      status: 'active',
      is_read: false
    }
  ];
  return NextResponse.json(alerts);
}
