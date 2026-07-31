import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

// CORS headers
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, Accept',
};

// Helper to add CORS headers to response
const addCorsHeaders = (res: NextResponse) => {
  Object.entries(corsHeaders).forEach(([key, value]) => {
    res.headers.set(key, value);
  });
  return res;
};

// Public routes that don't require authentication
const PUBLIC_ROUTES = ['/api/public', '/api/health', '/api/advisories', '/api/facilities/nearby'];

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Handle preflight requests
  if (request.method === 'OPTIONS') {
    return addCorsHeaders(NextResponse.json({}, { status: 200 }));
  }

  // Check if route is public
  if (PUBLIC_ROUTES.some(route => pathname.startsWith(route))) {
    return addCorsHeaders(NextResponse.next());
  }

  // Development bypass (optional - set BYPASS_AUTH=true in .env to disable auth)
  if (process.env.NODE_ENV === 'development' && process.env.BYPASS_AUTH === 'true') {
    console.warn('⚠️ Development mode: Authentication bypassed');
    return addCorsHeaders(NextResponse.next());
  }

  // Get Firebase token from Authorization header
  const authHeader = request.headers.get('authorization');
  const token = authHeader?.split('Bearer ')[1];

  if (!token) {
    return addCorsHeaders(
      NextResponse.json({ error: 'Unauthorized - No token provided' }, { status: 401 })
    );
  }

  try {
    // Import Firebase Admin dynamically
    const { adminAuth } = await import('@/lib/firebase-admin');
    
    // Verify the ID token
    const decodedToken = await adminAuth.verifyIdToken(token);
    
    // Add user info to headers for downstream handlers
    const requestHeaders = new Headers(request.headers);
    requestHeaders.set('x-user-id', decodedToken.uid);
    requestHeaders.set('x-user-email', decodedToken.email || '');
    
    // If you have custom claims for ward_code
    const wardCode = (decodedToken as any).ward_code;
    if (wardCode) {
      requestHeaders.set('x-ward-code', wardCode);
    }

    // Continue with the modified headers
    const response = NextResponse.next({
      request: { headers: requestHeaders },
    });
    
    return addCorsHeaders(response);
  } catch (error: any) {
    console.error('Authentication error:', error.message);
    
    return addCorsHeaders(
      NextResponse.json(
        { error: 'Invalid or expired token', details: error.message },
        { status: 401 }
      )
    );
  }
}

// Specify which paths this middleware should run on
export const config = {
  matcher: ['/api/:path*'],
};