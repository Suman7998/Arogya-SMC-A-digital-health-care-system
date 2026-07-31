# **Arogya-SMC: Public App Backend (API Gateway)**

---

## **System Overview**

The Public App Backend serves as the **API Gateway for the citizen-facing mobile application**.

It provides:

* hospital availability data
* health alerts and advisories
* push notification support

The system is designed as a **stateless REST API layer**, enabling fast and scalable access to public health information without requiring user authentication.

---

## **Architecture Overview**

* **Framework:** Next.js (API Routes)
* **Language:** TypeScript (Node.js)
* **Database:** PostgreSQL with PostGIS
* **Notifications:** Firebase Cloud Messaging (FCM)
* **Middleware:** CORS-enabled API layer

This backend acts as the **bridge between the database and mobile application**.

---

## **Core API Endpoints**

### **Public Data APIs**

**GET `/api/public/facilities`**
Returns hospital data with latest capacity information (beds, ICU, oxygen).

**GET `/api/public/alerts`**
Returns active health alerts (e.g., dengue, flu).

**GET `/api/public/advisories`**
Returns public health advisories for display in the app.

**GET `/api/public/wards`**
Returns ward boundary data (GeoJSON) for location mapping.

---

### **Notification APIs**

**POST `/api/notifications/register`**
Registers device FCM token for notifications.

**POST `/api/notifications/trigger`**
Triggers push notifications (restricted access).

---

## **Database Dependencies**

The backend uses the following core tables:

* `facilities` → hospital registry
* `capacity_reports` → bed and resource data
* `alerts` → outbreak alerts
* `advisories` → public health messages
* `device_tokens` → registered user devices

---

## **Security Model**

* Public endpoints are **open (no authentication required)**
* Notification system is **protected using a secret key**

```text
NOTIFICATION_TRIGGER_SECRET
```

This prevents unauthorized alert broadcasting.

---

## **Environment Configuration**

Create a `.env.local` file:

```env
DATABASE_URL=postgresql://postgres:password@localhost:5432/arogya_smc

JWT_SECRET=your_secret
NOTIFICATION_TRIGGER_SECRET=your_secret

FIREBASE_SERVICE_ACCOUNT={...}
```

---

## **Run Instructions**

```bash
npm install
npm run dev
```

The server will start and expose API endpoints.

---

## **Notes**

* Designed for high-read, low-write public traffic
* Optimized for fast response and simple data access
* Works with Arogya-SMC mobile applications
* Supports real-time alerts via Firebase

---
