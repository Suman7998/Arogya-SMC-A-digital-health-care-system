// lib/core/utils/ward_mapper.dart

class WardInfo {
  final String wardId;
  final String wardName;

  const WardInfo({required this.wardId, required this.wardName});
}

class WardMapper {
  WardMapper._();

  /// Dummy dataset mapping Solapur lat/lng zones to wards.
  static const List<_WardZone> _zones = [
    _WardZone(latMin: 17.680, latMax: 17.700, lngMin: 75.900, lngMax: 75.920, wardId: 'W01', wardName: 'Ward 01 – Budhwar Peth'),
    _WardZone(latMin: 17.700, latMax: 17.720, lngMin: 75.900, lngMax: 75.920, wardId: 'W02', wardName: 'Ward 02 – Mangalwar Peth'),
    _WardZone(latMin: 17.660, latMax: 17.680, lngMin: 75.880, lngMax: 75.910, wardId: 'W03', wardName: 'Ward 03 – Lashkar'),
    _WardZone(latMin: 17.670, latMax: 17.690, lngMin: 75.910, lngMax: 75.940, wardId: 'W04', wardName: 'Ward 04 – Hotgi Road'),
    _WardZone(latMin: 17.690, latMax: 17.710, lngMin: 75.880, lngMax: 75.900, wardId: 'W05', wardName: 'Ward 05 – Vijapuri'),
    _WardZone(latMin: 17.710, latMax: 17.730, lngMin: 75.910, lngMax: 75.930, wardId: 'W06', wardName: 'Ward 06 – Akkalkot Road'),
    _WardZone(latMin: 17.720, latMax: 17.745, lngMin: 75.880, lngMax: 75.910, wardId: 'W07', wardName: 'Ward 07 – Datta Nagar'),
    _WardZone(latMin: 17.650, latMax: 17.670, lngMin: 75.890, lngMax: 75.920, wardId: 'W08', wardName: 'Ward 08 – Ruikar Colony'),
    _WardZone(latMin: 17.680, latMax: 17.700, lngMin: 75.930, lngMax: 75.960, wardId: 'W09', wardName: 'Ward 09 – Shivaji Nagar'),
    _WardZone(latMin: 17.700, latMax: 17.720, lngMin: 75.930, lngMax: 75.960, wardId: 'W10', wardName: 'Ward 10 – Murarji Peth'),
    _WardZone(latMin: 17.660, latMax: 17.685, lngMin: 75.920, lngMax: 75.950, wardId: 'W11', wardName: 'Ward 11 – Sadar Bazar'),
    _WardZone(latMin: 17.675, latMax: 17.695, lngMin: 75.905, lngMax: 75.925, wardId: 'W12', wardName: 'Ward 12 – SMC Central'),
  ];

  static WardInfo mapToWard(double latitude, double longitude) {
    for (final zone in _zones) {
      if (latitude >= zone.latMin &&
          latitude <= zone.latMax &&
          longitude >= zone.lngMin &&
          longitude <= zone.lngMax) {
        return WardInfo(wardId: zone.wardId, wardName: zone.wardName);
      }
    }
    return const WardInfo(wardId: 'W00', wardName: 'Unknown Ward (Outside SMC)');
  }
}

class _WardZone {
  final double latMin;
  final double latMax;
  final double lngMin;
  final double lngMax;
  final String wardId;
  final String wardName;

  const _WardZone({
    required this.latMin,
    required this.latMax,
    required this.lngMin,
    required this.lngMax,
    required this.wardId,
    required this.wardName,
  });
}
