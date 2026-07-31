# **Arogya-SMC: Citizen Health Access & Engagement App**

---

## **System Overview**

The Arogya-SMC Citizen App is the public-facing mobile application of the Solapur Municipal Corporation health ecosystem.

It provides citizens with:

* real-time hospital availability
* localized health alerts
* public health advisories

The application enables **direct access to critical health information at ward level**, improving awareness and response.

---

## **Architecture Overview**

The application follows a modular and scalable architecture:

* **Framework:** Flutter (Dart) with Material Design
* **State Management:** Riverpod (reactive state + dependency injection)
* **Local Storage:** Hive (offline caching with TTL-based refresh)
* **Notifications:** Firebase Cloud Messaging (FCM)
* **Location Services:** Geolocator (ward detection using GPS)

The system is designed to remain responsive even under **low connectivity conditions**.

---

## **Core Features**

### **1. Hospital Discovery**

* View nearby hospitals
* Check availability of:

  * general beds
  * ICU units
  * ventilators
  * oxygen

---

### **2. Health Alerts**

* Real-time alerts based on:

  * disease outbreaks
  * vaccination drives
  * public health notices

---

### **3. Advisory System**

* Municipal advisories displayed via carousel
* Regular updates on public health guidelines

---

### **4. Emergency Access**

* One-tap access to:

  * Police (100)
  * Ambulance (108)
  * Fire (101)
  * SMC Helpline

---

### **5. Offline & Sync Support**

* Cached data for faster access
* Pull-to-refresh for manual updates
* Graceful handling of network failures

---

## **Project Structure**

```text
lib/
├── core/
│   ├── constants/        # App configs & API routes
│   ├── theme/            # UI design & styling
│   └── utils/            # Utility functions (ward mapping)
├── data/
│   ├── models/           # Data models
│   ├── repositories/     # Data handling logic
│   └── services/         # API & storage services
├── navigation/           # Routing setup
├── providers/            # Riverpod state management
├── views/                # Screens
└── widgets/              # UI components
```

---

## **Setup & Run Instructions**

### **Prerequisites**

* Flutter SDK (>= 3.x)
* Java 17 (important for Android build)

---

### **Configuration**

1. Set API base URL in:

```text
lib/core/constants/app_constants.dart
```

2. Add Firebase configuration file:

```text
android/app/google-services.json
```

---

### **Run Application**

```bash
flutter pub get
flutter run
```

---

### **Testing with Local Backend (IMPORTANT)**

If using a local backend:

```bash
adb reverse tcp:3000 tcp:3000
```

Set API URL to:

```text
http://localhost:3000/api
```

---

## **Notes**

* Works with backend API from Arogya-SMC platform
* Designed for low-end devices and real-world usage
* Supports offline caching and delayed synchronization

---
