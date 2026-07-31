# **Arogya-SMC: ASHA Worker Application**

---

## **System Overview**

The Arogya-SMC ASHA App is a mobile application designed for frontline health workers to collect and manage field-level health data.

It enables:

* syndromic data collection
* beneficiary tracking
* ward-level reporting

The application is built with an **offline-first approach**, ensuring reliable operation in low-connectivity environments. Data is automatically synchronized with the central system when the network becomes available.

---

## **Architecture Overview**

The app follows a modular and reactive architecture:

* **State Management:** Riverpod
* **Local Database:** Drift (SQLite)
* **Networking:** Dio
* **Connectivity Handling:** connectivity_plus
* **Location Services:** Geolocator

### **Data Flow**

```text
Local Database (Drift) → Repository → Provider → UI
```

### **Sync Mechanism**

* Data stored locally when offline
* SyncService monitors connectivity
* Automatically pushes pending data to backend
* Tracks status: Pending / Synced / Failed

---

## **Core Features**

### **1. Field Data Collection**

* Multi-step reporting flow
* Captures:

  * symptoms (fever, cough, diarrhea, etc.)
  * maternal and child risk indicators
  * environmental observations
  * GPS location
  * optional photo evidence

---

### **2. Geolocation Validation**

* Captures device coordinates
* Enables ward-level mapping
* Supports backend validation using geospatial queries

---

### **3. Beneficiary Management**

* Create and manage family records
* Track health visits and profiles
* QR-based identification support

---

### **4. Offline-First Operation**

* Data stored locally using SQLite
* Works without internet
* Syncs automatically when online

---

### **5. Report Generation**

* Generates structured reports
* Supports PDF export for field summaries

---

### **6. Multilingual Support**

* English and Marathi support
* Implemented using localization assets

---

## **Project Structure**

```text
lib/
├── core/            # Configurations and utilities
├── data/            # Models, repositories, services
├── providers/       # Riverpod state management
├── views/           # UI screens
└── widgets/         # Reusable UI components
```

---

## **Setup & Run Instructions**

### **Prerequisites**

* Flutter SDK (>= 3.x)
* Java 17 (required for Android build)

---

### **Configuration**

Set API base URL in:

```text
api_service.dart
```

For local testing:

```text
http://localhost:3001/api
```

---

### **Run Application**

```bash
flutter pub get
flutter run
```

---

### **For USB Debugging (IMPORTANT)**

```bash
adb reverse tcp:3001 tcp:3001
```

---

### **If Using Drift Code Generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## **Notes**

* Designed for real-world field conditions
* Optimized for low-end devices
* Supports offline data collection and delayed sync
* Works with Arogya-SMC backend platform

---

* what can still cost you selection
