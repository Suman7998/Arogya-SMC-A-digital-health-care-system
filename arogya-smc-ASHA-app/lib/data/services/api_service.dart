import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static String get baseUrl {
    // For USB debugging on physical device, use:
    // return 'http://10.0.2.2:3001/api';  // Only works for emulator
    // For physical device with USB, use adb reverse:
    // adb reverse tcp:3001 tcp:3001
    // Then use 'http://localhost:3001/api'
    
    // For Wi‑Fi (same network as computer):
    // return 'http://192.168.0.102:3001/api';
    
    // For USB debugging with adb reverse:
    return 'http://localhost:3001/api';
  }
  
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ApiService() {
    print('--- [API SERVICE] Initializing with BaseURL: $baseUrl ---');
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final user = _auth.currentUser;
          if (user != null) {
            final token = await user.getIdToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
        } catch (e) {
          _logger.e('Error getting Firebase Auth Token: $e');
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        _logger.e('Dio Error: ${error.message}', error: error);
        handler.next(error);
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (!options.path.contains('/health')) {
          _logger.i('--> ${options.method} ${options.uri}');
          if (options.data != null) _logger.d('Data: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (!response.requestOptions.path.contains('/health')) {
          _logger.i('<-- ${response.statusCode} ${response.requestOptions.uri}');
          if (response.data != null) _logger.d('Response: ${response.data}');
        }
        return handler.next(response);
      },
    ));
  }

  // --- GET ---
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _logger.e('GET Error [$path]: ${e.message}');
      rethrow;
    }
  }

  // --- POST ---
  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      _logger.e('POST Error [$path]: ${e.message}');
      rethrow;
    }
  }
}
