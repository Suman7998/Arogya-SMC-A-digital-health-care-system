// lib/providers/ward_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/ward_model.dart';
import '../data/services/api_service.dart';

final wardsProvider = FutureProvider<List<WardModel>>((ref) async {
  final api = ApiService();
  return api.fetchWards();
});
