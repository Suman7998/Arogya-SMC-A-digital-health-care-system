# ASHA Worker Mobile App for Arogya‑SMC: Complete Design Document

## 1. Understanding Existing ASHA/Anganwadi Worker Apps

### Research Insights from Poshan Tracker & Similar Apps

Based on analysis of Poshan Tracker :

**What They Do Well:**
- **Real-time data entry** for growth monitoring, service delivery, beneficiary tracking
- **Offline mode** for field work with connectivity issues
- **Beneficiary profiles** for pregnant women, lactating mothers, children 0-6 years
- **Aadhaar-linked verification** to prevent duplicates
- **Growth charts** with WHO standards, color-coded risk levels (green/yellow/red)
- **Geo-tagging** of centers and visits 
- **Photo-based verification** for attendance 

**What Users Hate (Critical Lessons):**

The Poshan Tracker has a **2.8-3.0 star rating** with 127,000+ reviews . User complaints include:

| Problem | Real User Quote | Our Solution |
|---------|-----------------|--------------|
| **Frequent crashes** | "In the pursuit to smoothen and digitise the work of an AWW, this app has been total disaster. Frequent crash"  | Robust error handling, crash reporting, thorough testing |
| **GPS failures** | "high failure to obtain correct GPS location" and "Despite being present at the centre, the location itself is shown as wrong"  | Graceful fallback, manual location entry option |
| **Slow performance** | "slow processing, issues are never ending"  | Lightweight architecture, optimized queries |
| **Poor UI/UX** | "Poor UI/UX design makes the Poshan Tracker app extremely frustrating to use. It's built for non-tech-savvy women, yet the interface is overly complex and confusing."  | **Simple, intuitive design with large buttons, clear labels** |
| **Heavy app size** | "The app is heavy, very slow, and consumes too much data"  | Target <40 MB, optimize assets |
| **Old device issues** | "The biggest problem... mobile phones which the government has given to the mobile users with very old system."  | Support Android 5.0+, test on low-end devices |
| **Updates making things worse** | "with every upgrade, the number of problems only reach newer heights"  | Thorough regression testing |

### Key Features of Existing Systems 

| Feature Category | Details |
|------------------|---------|
| **Beneficiary Management** | Pregnant women, lactating mothers, children 0-6 years, adolescent girls |
| **Services Tracked** | Iron/folic acid intake, antenatal checkups, tetanus injections, nutrition supplements, postnatal care |
| **Growth Monitoring** | Weight, height, WHO-standard growth curves, color-coded risk |
| **Daily Operations** | Attendance tracking, take-home rations (THR), hot cooked meals (HCM) |
| **Verification** | Aadhaar-linked profiles, photo-based verification |
| **Location** | Center geo-tagging |

---

## 2. Technology Stack for ASHA App (100% Free)

### Core Framework

| Component | Technology | Justification |
|-----------|------------|---------------|
| **Framework** | Flutter 3.27+ | Single codebase, excellent offline support, works on low-end devices |
| **Language** | Dart 3.5+ | Modern, type-safe |
| **IDE** | VS Code | Free, excellent Flutter plugins |

### State Management & Architecture

| Component | Technology | Purpose |
|-----------|------------|---------|
| **State Management** | Riverpod 2.5+ | Testable, no context dependency |
| **Navigation** | GoRouter 14.0+ | Declarative routing |
| **Architecture** | MVVM (Clean Architecture) | Clear separation of concerns |

### Local Storage & Offline

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Local Database** | **Drift** (formerly Moor) | Type-safe SQLite, better than raw SQLite, excellent offline support |
| **Secure Storage** | flutter_secure_storage | For tokens, credentials |
| **Connectivity** | connectivity_plus | Detect network status |
| **Work Manager** | flutter_workmanager | Background sync even when app closed |

### Networking

| Component | Technology | Purpose |
|-----------|------------|---------|
| **HTTP Client** | Dio 5.4+ | Interceptors, retry logic, timeouts |
| **API Client Generator** | Retrofit (for Dart) | Type-safe API calls |

### Utilities

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Location** | geolocator 12.0+ | GPS for center geo-tagging |
| **Camera** | camera | Photo capture for verification |
| **Image Picker** | image_picker | Select images |
| **Permissions** | permission_handler | Runtime permissions |
| **Push Notifications** | firebase_messaging | Receive alerts from MHO |
| **Localization** | easy_localization | Marathi, Hindi, English |
| **QR Scanner** | mobile_scanner | Optional Aadhaar scan |
| **File Download** | flutter_downloader | Download reports |

---

## 3. Features & Functions for ASHA App

### Core Features (Must-Have for March 23)

| Feature | Description | Priority |
|---------|-------------|----------|
| **F1: Secure Login** | OTP-based login (simulate with demo mode for prototype) | HIGH |
| **F2: Dashboard** | Today's pending reports, recent alerts, quick actions | HIGH |
| **F3: Daily Syndromic Report** | Fever, cough, diarrhea counts with geotagging | HIGH |
| **F4: Maternal Risk Flagging** | Pregnancy complications, high-risk indicators | HIGH |
| **F5: Child Risk Flagging** | Malnutrition flags, growth monitoring | HIGH |
| **F6: Environmental Flags** | Stagnant water, poor sanitation | HIGH |
| **F7: Offline Storage** | Save reports without internet, sync later | HIGH |
| **F8: Alert List** | View outbreak alerts from MHO | MEDIUM |
| **F9: Push Notifications** | Receive real-time alerts | MEDIUM |
| **F10: Sync Status** | Visual indicator of pending/synced reports | MEDIUM |

### Secondary Features (Post-Prototype)

| Feature | Description |
|---------|-------------|
| **Beneficiary List** | View families in assigned ward |
| **Growth Charts** | Track child growth over time |
| **Visit History** | Past reports and visits |
| **QR Scan** | Quick beneficiary lookup |
| **Report Generation** | Download monthly summaries |

---

## 4. Data Model for ASHA Reports

Based on the workflow analysis from existing systems , here's what ASHA workers need to record:

```dart
class ASHAReport {
  final String reportId;
  final String ashaWorkerId;
  final String wardCode;
  final DateTime reportDate;
  final DateTime submissionTime; // For sync tracking
  final bool isSynced;
  
  // Syndromic Surveillance
  final SyndromicData syndromic;
  
  // Maternal Health
  final MaternalHealthData maternal;
  
  // Child Health
  final ChildHealthData child;
  
  // Environmental
  final EnvironmentalData environmental;
  
  // Location
  final GeoLocation location; // Lat/lng of report
}

class SyndromicData {
  final int feverCount;
  final int coughCount;
  final int diarrheaCount;
  final int jaundiceCount;
  final Map<String, int> otherSymptoms; // Flexible for new outbreaks
}

class MaternalHealthData {
  final int pregnantWomenCount;
  final int highRiskPregnancyCount; // Flags
  final int ancVisitsConducted; // Antenatal care
  final int ironSupplementDistributed;
}

class ChildHealthData {
  final int childrenUnder5;
  final int malnourishedCount; // Severe acute malnutrition
  final int immunizationDue;
  final Map<String, double> growthMeasurements; // Weight, height
}

class EnvironmentalData {
  final bool stagnantWaterPresent;
  final bool poorSanitation;
  final bool garbageDumping;
  final String? otherRisks;
}

class GeoLocation {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String? placemark; // Reverse geocoded ward
}
```

---

## 5. Pages / Screens Design

### Screen Overview

| Screen | Route | Purpose |
|--------|-------|---------|
| **Splash** | `/` | Loading, check auth |
| **Login** | `/login` | OTP-based login (demo mode for prototype) |
| **Dashboard** | `/dashboard` | Home screen with overview |
| **New Report** | `/report/new` | Step-by-step data entry |
| **Report Review** | `/report/review` | Review before submit |
| **Alert List** | `/alerts` | View all alerts |
| **Alert Detail** | `/alert/{id}` | Detailed alert view |
| **Sync Status** | `/sync` | Pending reports, sync progress |
| **Settings** | `/settings` | Language, about |

### Screen Flow Diagram

```
[Splash] → [Login] → [Dashboard]
                      ↓
              ┌───────┼───────┐
              ↓       ↓       ↓
        [New Report] [Alerts] [Sync Status]
              ↓                ↑
        [Report Review] ───────┘
              ↓
        [Submit / Save]
```

### Screen 1: Login Screen (`/login`)

**Purpose:** Authenticate ASHA worker

**UI Elements:**
- App logo
- Phone number input (read-only for demo with pre-filled number)
- "Get OTP" button
- OTP input (simulate with "123456" for demo)
- "Login" button
- "Demo Mode" toggle (for prototype)

**Logic:**
- For prototype: hardcoded OTP bypass
- Store worker ID and ward mapping
- Navigate to Dashboard

### Screen 2: Dashboard (`/dashboard`)

**Purpose:** Home screen for daily workflow

**UI Elements:**
- Welcome message with worker name
- **Stats Cards:**
  - Today's reports submitted
  - Pending reports (offline count)
  - Unread alerts count
- **Quick Actions Grid:**
  - 📝 New Daily Report
  - 👩 Maternal Risk
  - 👶 Child Risk
  - 🌍 Environment Flag
  - ⚠️ View Alerts
  - 📤 Sync Status
- **Recent Alerts** (latest 2-3)
- **Sync Status Bar** (showing pending count)

**Design Principles:**
- Large touch targets (minimum 48x48dp)
- High contrast colors
- Simple language (Marathi/Hindi/English)
- Clear visual feedback on taps

### Screen 3: New Report Flow (Multi-step)

Based on the systematic data collection process in existing apps :

**Step 1: Syndromic Surveillance**
```
📋 Step 1/4: Symptom Counts

🟦 Fever Count: [  5  ]  ➕
🟦 Cough Count: [  3  ]  ➕
🟦 Diarrhea:    [  2  ]  ➕
🟦 Jaundice:    [  0  ]  ➕

[Other Symptoms (optional)]

[Next →]
```

**Step 2: Maternal & Child Health**
```
👩 Step 2/4: Maternal & Child

Pregnant Women:       [ 2 ]
High Risk Pregnancy:  [ 0 ]
ANC Visits Done:      [ 1 ]

Children Under 5:     [ 8 ]
Malnourished:         [ 1 ]
Immunization Due:     [ 3 ]

[← Back] [Next →]
```

**Step 3: Environmental**
```
🌍 Step 3/4: Environment

☑ Stagnant Water?      [Yes/No]
☑ Poor Sanitation?     [Yes/No]
☑ Garbage Dumping?     [Yes/No]

Other Risks: [________________]

[← Back] [Next →]
```

**Step 4: Location & Review**
```
📍 Step 4/4: Location

📍 Current Location Captured
   Ward: Sadar Bazaar
   Accuracy: 10m

[Recapture Location if needed]

[Review Full Report]
[Save Draft] [Submit]
```

**Key Design Decisions:**
- **Progress indicator** shows step position
- **Large +/- buttons** for count adjustment
- **Default values** from previous day (optional)
- **Validation** on each step
- **Save draft** for offline

### Screen 4: Report Review

**Purpose:** Review all data before final submission

**UI Elements:**
- Summary cards for each section
- Edit buttons per section
- "Submit Now" button
- "Save for Later" button

### Screen 5: Alert List (`/alerts`)

**Purpose:** View all received alerts

**UI Elements:**
- List of alerts with:
  - Severity color (red/orange/blue)
  - Title
  - Date
  - Brief description
- Tap to view full details
- Unread indicator

### Screen 6: Sync Status (`/sync`)

**Purpose:** Manage offline reports

**UI Elements:**
- Pending reports count
- List of pending reports with dates
- "Sync Now" button
- Last sync timestamp
- Individual report retry option

---

## 6. Offline-First Architecture

Based on the critical requirement from field workers :

### Data Flow

```
[User Input] → [Local Database (Drift)] → [Sync Queue]
                                              ↓
                                     [Background Sync]
                                              ↓
                                        [API Gateway]
                                              ↓
                                        [Cloud Storage]
```

### Sync Strategy

1. **On Report Save:**
   - Save to local Drift database with `syncStatus = pending`
   - Add to sync queue
   - Show in pending list

2. **On Network Available:**
   - Background sync worker runs
   - Processes queue FIFO
   - On success: mark as `synced`
   - On failure: retry with exponential backoff

3. **Conflict Resolution:**
   - Server timestamp wins
   - If conflict detected, fetch latest from server and merge intelligently

### Local Database Schema (Drift)

```dart
// drift file
import 'package:drift/drift.dart';

class Reports extends Table {
  TextColumn get reportId => text().unique()();
  TextColumn get ashaWorkerId => text()();
  TextColumn get wardCode => text()();
  DateTimeColumn get reportDate => dateTime()();
  DateTimeColumn get submissionTime => dateTime()();
  IntColumn get syncStatus => integer()(); // 0=pending, 1=synced, 2=error
  
  // Syndromic data stored as JSON
  TextColumn get syndromicData => text()(); 
  TextColumn get maternalData => text()();
  TextColumn get childData => text()();
  TextColumn get environmentalData => text()();
  
  // Location
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  
  @override
  Set<Column> get primaryKey => {reportId};
}
```

---

## 7. Push Notification Flow

**Purpose:** Receive outbreak alerts and advisories from MHO

**Implementation:**
- Firebase Cloud Messaging (FCM)
- Subscribe to `ward_{wardCode}` topic on login
- Receive notifications for ward-specific alerts
- Store alerts in local database
- Show notification badge on dashboard

---

## 8. Key Lessons from Poshan Tracker Reviews 

### What We MUST Avoid

| Problem | Our Solution |
|---------|--------------|
| **Frequent crashes** | Comprehensive error handling, crash reporting (Firebase Crashlytics), testing on real devices |
| **GPS failures** | Manual location entry fallback, cache last known location, retry mechanism |
| **Slow performance** | Lazy loading, pagination, optimized queries, <40MB app size |
| **Complex UI** | Large buttons, minimal text, step-by-step wizards, icon-based navigation |
| **Old device issues** | Test on Android 5.0+ devices, use lightweight dependencies |
| **Data heavy** | Compress images, batch sync, use protobuf or compact JSON |
| **Poor updates** | Regression testing before release, staged rollouts |

### What Users Want 

- **Simplicity** – "designed for real people, not computer experts"
- **Large buttons** – "clean interface, buttons are big"
- **Offline capability** – "works offline in some areas"
- **Fast data entry** – "update a child's weight and move on"
- **Visual feedback** – "color-coded risk levels"

---

## 9. Implementation Priority (13 Days)

| Priority | Screens/Features | Day Allocation |
|----------|------------------|----------------|
| **P1 (Must Have)** | Project setup, Drift database, Login, Dashboard, New Report form (basic), offline save | Days 1-5 |
| **P2 (Should Have)** | Multi-step wizard, sync queue, background sync, API integration | Days 6-8 |
| **P3 (Nice to Have)** | Alert list, push notifications, multi-language, settings | Days 9-11 |
| **Buffer** | Testing, bug fixes, video recording | Days 12-13 |

### Day-by-Day Breakdown

| Day | Focus |
|-----|-------|
| 1 | Project setup, architecture, Drift database schema |
| 2 | Login screen, dashboard UI |
| 3 | New Report – Step 1 (Syndromic) with offline save |
| 4 | Steps 2-3 (Maternal/Child/Environmental) |
| 5 | Step 4 (Location) and Report Review |
| 6 | Sync queue implementation, background worker |
| 7 | API integration (POST reports) |
| 8 | Alert list screen, basic notifications |
| 9 | Multi-language (Marathi translations) |
| 10 | Polish, error handling, loading states |
| 11 | Testing on multiple devices/emulators |
| 12 | Bug fixes, performance optimization |
| 13 | Final testing, video recording |

---

## 10. Integration with Arogya‑SMC Backend

### API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/asha/login` | POST | OTP verification (demo: simulate) |
| `/api/asha/report` | POST | Submit completed report |
| `/api/asha/pending` | GET | Get pending reports (for sync) |
| `/api/asha/alerts` | GET | Fetch alerts |
| `/api/ward/{code}` | GET | Get ward details |

### Authentication Flow (Prototype)

For demo purposes, simplify:
1. Hardcoded worker list in `users.json`
2. "Login" accepts any 6-digit number ending with registered phone
3. JWT token returned (simulated)
4. Store token securely

---

## 11. Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── themes/
│   └── utils/
├── data/
│   ├── models/
│   │   ├── report.dart
│   │   ├── alert.dart
│   │   └── user.dart
│   ├── database/
│   │   ├── database.dart (Drift)
│   │   ├── report_dao.dart
│   │   └── sync_queue_dao.dart
│   ├── repositories/
│   │   ├── report_repository.dart
│   │   ├── alert_repository.dart
│   │   └── auth_repository.dart
│   └── services/
│       ├── api_service.dart
│       ├── sync_service.dart
│       └── location_service.dart
├── providers/
│   ├── report_provider.dart
│   ├── auth_provider.dart
│   └── sync_provider.dart
├── views/
│   ├── splash/
│   ├── login/
│   ├── dashboard/
│   ├── report/
│   │   ├── step1_syndromic.dart
│   │   ├── step2_maternal.dart
│   │   ├── step3_environment.dart
│   │   ├── step4_location.dart
│   │   └── report_review.dart
│   ├── alerts/
│   └── settings/
└── l10n/ (localization files)
```

---

## 12. Success Criteria for Demo Video

The 4-5 minute video should clearly show:

1. **Login** – Simple OTP/demo login
2. **Dashboard** – Overview of today's tasks
3. **New Report Flow** – Step through all 4 screens entering data
4. **Offline Indicator** – Show report saved locally
5. **Sync** – When online, report syncs (visual feedback)
6. **Alert Reception** – Show notification and alert list
7. **Language Switch** – (Optional) Toggle to Marathi

---

## Conclusion

The ASHA app design incorporates lessons learned from existing government apps like Poshan Tracker , avoiding common pitfalls while building a lightweight, offline-first, user-friendly interface. By focusing on the core data collection needs—syndromic surveillance, maternal/child risk flags, and environmental observations—and implementing robust offline sync, this app will serve as a reliable tool for Solapur's frontline health workers while integrating seamlessly with the broader Arogya‑SMC ecosystem.

