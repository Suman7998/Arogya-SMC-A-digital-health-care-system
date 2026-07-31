# **Arogya-SMC: ASHA Worker Backend (API Gateway & Ingestion Layer)**

---

## **System Overview**

The ASHA Worker Backend is the **secure API layer** responsible for collecting, validating, and storing field-level health data from ASHA workers.

It supports:

* offline-first data synchronization
* beneficiary and visit tracking
* ward-level data validation

The backend ensures that all incoming data is **structured, validated, and stored reliably**.

---

## **Architecture Overview**

* **Framework:** Next.js (API Routes)
* **Language:** TypeScript (Node.js)
* **Database:** PostgreSQL with PostGIS
* **Data Format:** JSON + relational tables
* **Authentication:** Firebase (JWT-based RBAC)

This backend acts as the **core ingestion layer** for field surveillance data.

---

## **Core API Endpoints**

### **1. Spatial Validation**

**GET `/api/wards/detect`**

* Accepts GPS coordinates
* Returns corresponding ward
* Used to validate report location

---

### **2. Data Ingestion**

**POST `/api/reports`**

* Submits field reports
* Includes:

  * symptoms (fever, cough, etc.)
  * risk indicators
  * location data
  * optional media

---

**POST `/api/sync`**

* Accepts batch data from mobile app
* Used for offline-first synchronization

---

### **3. Beneficiary & Health Tracking**

**POST `/api/beneficiaries`**

* Register family details

**POST `/api/beneficiaries/children`**

* Store child records

**POST `/api/visits`**

* Log field visits

**POST `/api/vaccinations`**

* Track immunization data

**POST `/api/growth_measurements`**

* Store height, weight, and growth metrics

---

## **Database Structure**

The backend uses the following key tables:

* `asha_reports` → field data
* `beneficiaries` → family records
* `children` → child profiles
* `visits` → visit logs
* `vaccinations` → immunization data
* `growth_measurements` → child growth tracking
* `wards` → geospatial boundaries

---

## **Security Model**

* All write operations require **authenticated users**
* Firebase JWT is used for identity verification
* Middleware enforces access control
* CORS enabled for mobile app communication

---

## **Environment Configuration**

Create `.env.local`:

```env
DATABASE_URL=postgresql://postgres:password@localhost:5432/arogya_smc

JWT_SECRET=your_secret
FIREBASE_SERVICE_ACCOUNT={...}
```

---

## **Run Instructions**

```bash
npm install
npm run dev
```

---

## **Notes**

* Designed for offline-first mobile integration
* Supports batch synchronization from local storage
* Ensures accurate location-based validation
* Forms the core data ingestion layer of Arogya-SMC

---
