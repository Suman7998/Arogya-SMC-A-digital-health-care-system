import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';
import '../../../../data/models/models.dart';
import '../../../widgets/report_photo_section.dart';

class Step3LocationView extends ConsumerStatefulWidget {
  const Step3LocationView({super.key});

  @override
  ConsumerState<Step3LocationView> createState() => _Step3LocationViewState();
}

class _Step3LocationViewState extends ConsumerState<Step3LocationView> {
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _wards = [];
  bool _manualSelection = false;

  @override
  void initState() {
    super.initState();
    _fetchWards();
  }

  Future<void> _fetchWards() async {
    try {
      final api = ref.read(apiServiceProvider);
      final res = await api.get('/wards');
      if (res.statusCode == 200 && res.data['data'] != null) {
        setState(() {
          _wards = List<Map<String, dynamic>>.from(res.data['data']);
        });
      }
    } catch (e) {
      // Ignore gracefully
    }
  }

  Future<void> _captureLocation() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _manualSelection = false;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'Location permission denied. Please select ward manually.';
            _isLoading = false;
            _manualSelection = true;
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = 'Location permanently denied. Please select ward manually.';
          _isLoading = false;
          _manualSelection = true;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      String placemarkName;
      try {
        final api = ref.read(apiServiceProvider);
        final response = await api.get('/wards/detect', queryParameters: {
          'lat': position.latitude.toString(),
          'lng': position.longitude.toString(),
        });
        
        if (response.statusCode == 200) {
          final ward = response.data['data'];
          placemarkName = '${ward['ward_name']} (${ward['ward_code']})';
        } else {
          throw Exception('Ward detection failed');
        }
      } catch (e) {
        // Fallback to local geocoding
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          if (placemarks.isNotEmpty) {
            final p = placemarks.first;
            placemarkName = '${p.subLocality ?? p.locality ?? ""}, ${p.subAdministrativeArea ?? p.administrativeArea ?? ""}'.trim();
            if (placemarkName.startsWith(',')) placemarkName = placemarkName.substring(1).trim();
            if (placemarkName.isEmpty) placemarkName = 'GPS Locked (${position.latitude.toStringAsFixed(4)})';
          } else {
            placemarkName = 'GPS Locked (${position.latitude.toStringAsFixed(4)})';
          }
        } catch (e2) {
          placemarkName = 'GPS Locked (${position.latitude.toStringAsFixed(4)})';
        }
      }

      ref.read(reportWizardProvider.notifier).updateLocation(
            GeoLocation(
              latitude: position.latitude,
              longitude: position.longitude,
              accuracy: position.accuracy,
              placemark: placemarkName,
            ),
          );

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _error = 'Could not detect ward. Please select manually.';
        _isLoading = false;
        _manualSelection = true;
      });
    }
  }

  void _useMockLocation() {
    ref.read(reportWizardProvider.notifier).updateLocation(
          const GeoLocation(
            latitude: 17.6868,
            longitude: 75.9072,
            accuracy: 10.0,
            placemark: 'Solapur, Maharashtra',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(reportWizardProvider).location;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withAlpha(20),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color(0xFF1565C0).withAlpha(77)),
            ),
            child: const Row(
              children: [
                Text('📍', style: TextStyle(fontSize: 40)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location & Photos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1565C0),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Capture your GPS location and add photos for this report',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Location Display
          if (location != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
                border: Border.all(color: AppColors.normalGreen.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.normalGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_rounded, color: AppColors.normalGreen, size: 32),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Location Locked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.placemark ?? 'Area Name Not Available',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  _LocationRow('Latitude', location.latitude.toStringAsFixed(6), Icons.north_east_rounded),
                  const SizedBox(height: 12),
                  _LocationRow('Longitude', location.longitude.toStringAsFixed(6), Icons.south_east_rounded),
                  const SizedBox(height: 12),
                  _LocationRow('Accuracy', '±${location.accuracy.toStringAsFixed(1)} Meters', Icons.gps_fixed_rounded),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Error Message
          if (_error != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.warningYellow.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.warningYellow.withAlpha(102)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_outlined,
                      color: AppColors.warningYellow),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _error!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Manual Selection Dropdown
          if (_manualSelection && _wards.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Ward Manually', style: TextStyle(fontFamily: 'Poppins')),
                  items: _wards.map((w) {
                    final label = '${w['ward_name']} (${w['ward_code']})';
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(label, style: const TextStyle(fontFamily: 'Poppins')),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      final currentLoc = ref.read(reportWizardProvider).location;
                      ref.read(reportWizardProvider.notifier).updateLocation(
                            GeoLocation(
                              latitude: currentLoc?.latitude ?? 0.0,
                              longitude: currentLoc?.longitude ?? 0.0,
                              accuracy: currentLoc?.accuracy ?? 0.0,
                              placemark: val,
                            ),
                          );
                      setState(() {
                        _error = null;
                        _manualSelection = false;
                      });
                    }
                  },
                ),
              ),
            ),
          ],

          // Capture Button
          SizedBox(
            height: 58,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _captureLocation,
              icon: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5))
                  : const Icon(Icons.my_location, size: 26),
              label: Text(
                _isLoading
                    ? 'Getting location...'
                    : location != null
                        ? 'Update Location'
                        : 'report.capture_location'.tr(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),

          if (location == null) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _useMockLocation,
                icon: const Icon(Icons.location_pin),
                label: const Text(
                  'Use Default Location (Solapur)',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
          ],

          const SizedBox(height: 32),
          const ReportPhotoSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _LocationRow(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
