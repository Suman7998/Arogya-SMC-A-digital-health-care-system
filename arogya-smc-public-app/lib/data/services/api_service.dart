import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../models/hospital_model.dart';
import '../models/alert_model.dart';
import '../models/advisory_model.dart';
import '../models/ward_model.dart';

class ApiService {
  static final Uri _base = Uri.parse(AppConstants.apiBaseUrl);

  Future<List<Map<String, dynamic>>> _getList(String endpoint) async {
    final url = _base.replace(path: _base.path + endpoint);
    final response = await http.get(url).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Server error ${response.statusCode} for $endpoint');
    }

    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      return decoded.cast<Map<String, dynamic>>();
    }

    // Some endpoints might return { "data": [...] }
    if (decoded is Map && decoded['data'] is List) {
      return (decoded['data'] as List).cast<Map<String, dynamic>>();
    }

    throw Exception('Unexpected response format from $endpoint');
  }

  Future<List<HospitalModel>> fetchFacilities() async {
    final list = await _getList(AppConstants.facilitiesEndpoint);
    return list.map((json) => HospitalModel.fromJson(json)).toList();
  }

  Future<List<AlertModel>> fetchAlerts() async {
    final list = await _getList(AppConstants.alertsEndpoint);
    return list.map((json) => AlertModel.fromJson(json)).toList();
  }

  Future<List<AdvisoryModel>> fetchAdvisories() async {
    final list = await _getList(AppConstants.advisoriesEndpoint);
    return list.map((json) => AdvisoryModel.fromJson(json)).toList();
  }

  Future<List<WardModel>> fetchWards() async {
    final list = await _getList(AppConstants.wardsEndpoint);
    return list.map((json) => WardModel.fromJson(json)).toList();
  }
}
