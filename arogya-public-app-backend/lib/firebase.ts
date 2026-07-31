import admin from 'firebase-admin';

if (!admin.apps.length) {
  const serviceAccount = process.env.FIREBASE_SERVICE_ACCOUNT;
  if (serviceAccount) {
    admin.initializeApp({
      credential: admin.credential.cert(JSON.parse(serviceAccount)),
    });
  } else {
    // Fallback for local development (use default credentials)
    admin.initializeApp();
  }
}

export async function sendMulticast(
  tokens: string[],
  title: string,
  body: string,
  data?: Record<string, string>
) {
  if (!tokens.length) return;

  const message = {
    notification: { title, body },
    data: data || {},
    tokens,
  };

  try {
    const response = await admin.messaging().sendEachForMulticast(message);
    console.log(`Sent ${response.successCount} notifications, failed ${response.failureCount}`);
    return response;
  } catch (error) {
    console.error('FCM multicast error:', error);
    throw error;
  }
}