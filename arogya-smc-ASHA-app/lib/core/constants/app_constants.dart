class AppRoutes {
  static const String splash = '/';
  static const String roleSelection = '/role';
  static const String login = '/login';
  static const String loginDashboard = '/login-dashboard';
  static const String createAccount = '/create-account';
  static const String otpVerification = '/otp-verification';
  static const String verifyEmail = '/verify-email';
  static const String dashboard = '/dashboard';
  static const String newReport = '/report/new';
  static const String reportStep1 = '/report/step1';
  static const String reportStep2 = '/report/step2';
  static const String reportStep3 = '/report/step3';
  static const String reportStep4 = '/report/step4';
  static const String reportStep5 = '/report/step5';
  static const String alerts = '/alerts';
  static const String sync = '/sync';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String reportHistory = '/report/history';
  static const String reportDetail = '/report/detail';
  static const String beneficiaryList = '/beneficiaries';
  // Family-level detail: opens full family profile with Add Visit / Vaccination
  static const String familyDetail = '/families/detail/:familyId';
  // Individual beneficiary detail (mother/head profile)
  static const String beneficiaryDetail = '/beneficiaries/detail/:id';
  static const String qrScanner = '/beneficiaries/qr';
  static const String growthChart = '/growth/chart/:childId';
  static const String growthMonitoring = '/growth/monitoring';
  static const String monthlyReports = '/reports/monthly';
  // Visit entry: pass beneficiaryId in path
  static const String addVisit = '/visits/new/:beneficiaryId';
  // Vaccination: pass beneficiaryId in path
  static const String vaccination = '/vaccination/:beneficiaryId';
  static const String familyDashboard = '/families/dashboard';

  static const String addFamily = '/families/new';
  static const String addMember = '/families/:familyId/add-member';

  // Extra ASHA Support Features
  static const String emergencyHelp = '/extra/emergency';
  static const String medicineTracker = '/extra/medicine';
  static const String dailyTasks = '/extra/tasks';
  static const String nearbyFacilities = '/extra/facilities';
}

class AppConstants {
  static const String appName = 'Arogya SMC';
  static const String version = '1.0.0';
  static const String buildNumber = '100';

  // Mock ASHA Workers data
  static const List<Map<String, String>> mockWorkers = [
    {
      'username': 'asha01',
      'password': 'asha123',
      'name': 'Meena Jadhav',
      'ward': 'W01',
      'wardName': 'Sadar Bazaar Ward',
      'phone': '9876543212',
    },
    {
      'username': 'asha02',
      'password': 'asha123',
      'name': 'Sunita Pawar',
      'ward': 'W02',
      'wardName': 'Siddheshwar Ward',
      'phone': '9876543213',
    },
    {
      'username': 'demo',
      'password': 'demo123',
      'name': 'Demo Worker',
      'ward': 'W03',
      'wardName': 'Railway Colony Ward',
      'phone': '9876500000',
    },
  ];

  // Ward list from DB
  static const List<Map<String, String>> wards = [
    {'code': 'W01', 'name': 'Ward 1 - North'},
    {'code': 'W02', 'name': 'Ward 2 - Railway Lines'},
    {'code': 'W03', 'name': 'Ward 3 - Bhavani Peth'},
    {'code': 'W04', 'name': 'Ward 4 - Murarji Peth'},
    {'code': 'W05', 'name': 'Ward 5 - Jule Solapur'},
    {'code': 'W06', 'name': 'Ward 6 - Sadar Bazar'},
    {'code': 'W07', 'name': 'Ward 7 - Civil Lines'},
    {'code': 'W08', 'name': 'Ward 8 - MIDC'},
    {'code': 'W09', 'name': 'Ward 9 - South'},
    {'code': 'W10', 'name': 'Ward 10 - East'},
    {'code': 'W11', 'name': 'Ward 11 - West'},
    {'code': 'W12', 'name': 'Ward 12 - Central'},
    {'code': 'W13', 'name': 'Ward 13 - Solapur Univ'},
    {'code': 'W14', 'name': 'Ward 14 - Kanna Chowk'},
    {'code': 'W15', 'name': 'Ward 15 - Budhwar Peth'},
    {'code': 'W16', 'name': 'Ward 16 - Shaniwar Peth'},
    {'code': 'W17', 'name': 'Ward 17 - Raviwar Peth'},
    {'code': 'W18', 'name': 'Ward 18 - Somwar Peth'},
    {'code': 'W19', 'name': 'Ward 19 - Mangalwar Peth'},
    {'code': 'W20', 'name': 'Ward 20 - Guruwar Peth'},
    {'code': 'W21', 'name': 'Ward 21 - Shukrawar Peth'},
    {'code': 'W22', 'name': 'Ward 22 - Daji Peth'},
    {'code': 'W23', 'name': 'Ward 23 - Navi Peth'},
    {'code': 'W24', 'name': 'Ward 24 - Bale'},
    {'code': 'W25', 'name': 'Ward 25 - Soregaon'},
    {'code': 'W26', 'name': 'Ward 26 - Majrewadi'},
  ];

  static const String userKey = 'current_user';
  static const String tokenKey = 'auth_token';
  static const String languageKey = 'selected_language';
  static const String lastSyncKey = 'last_sync_time';

  static const int syncIntervalMinutes = 30;
  static const int locationTimeoutSeconds = 30;
}
