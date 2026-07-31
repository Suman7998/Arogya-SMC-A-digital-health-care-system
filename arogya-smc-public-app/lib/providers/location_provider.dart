// lib/providers/location_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../core/utils/ward_mapper.dart';

class LocationState {
  final double? latitude;
  final double? longitude;
  final WardInfo? wardInfo;
  final bool isLoading;
  final String? error;

  const LocationState({
    this.latitude,
    this.longitude,
    this.wardInfo,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    double? latitude,
    double? longitude,
    WardInfo? wardInfo,
    bool? isLoading,
    String? error,
  }) =>
      LocationState(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        wardInfo: wardInfo ?? this.wardInfo,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(const LocationState());

  Future<void> detectLocation() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        // Use a default Solapur center coordinate as fallback
        const lat = 17.6868;
        const lng = 75.9063;
        final ward = WardMapper.mapToWard(lat, lng);
        state = state.copyWith(
          latitude: lat,
          longitude: lng,
          wardInfo: ward,
          isLoading: false,
          error: 'Location permission denied. Showing default ward.',
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      final ward = WardMapper.mapToWard(position.latitude, position.longitude);
      state = state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        wardInfo: ward,
        isLoading: false,
      );
    } catch (e) {
      // Fallback: Solapur city center
      const lat = 17.6868;
      const lng = 75.9063;
      final ward = WardMapper.mapToWard(lat, lng);
      state = state.copyWith(
        latitude: lat,
        longitude: lng,
        wardInfo: ward,
        isLoading: false,
        error: 'Could not detect location. Showing default.',
      );
    }
  }
}

final locationProvider =
    StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(),
);
