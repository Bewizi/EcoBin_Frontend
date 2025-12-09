import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Check if location services are enabled
  Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check location permission status
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Request location permission
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Handle location permissions (check and request if needed)
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException(
        'Location services are disabled. Please enable location services.',
      );
    }

    // Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException(
          'Location permissions are denied',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationServiceDisabledException(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return true;
  }

  /// Get current position
  Future<Position> getCurrentPosition() async {
    await handleLocationPermission();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Get current position with custom settings
  Future<Position> getCurrentPositionWithSettings({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? timeLimit,
  }) async {
    await handleLocationPermission();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: accuracy,
      timeLimit: timeLimit,
    );
  }

  /// Open location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Open app settings
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Get distance between two points (in meters)
  double getDistanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Get bearing between two points
  double getBearingBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Stream of position updates
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
    Duration? intervalDuration,
  }) {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}

// Custom Exceptions
class LocationServiceDisabledException implements Exception {
  final String? message;

  LocationServiceDisabledException([this.message]);

  @override
  String toString() {
    return 'LocationServiceDisabledException: $message';
  }
}

class LocationPermissionDeniedException implements Exception {
  final String message;
  LocationPermissionDeniedException(this.message);

  @override
  String toString() => message;
}

class LocationPermissionDeniedForeverException implements Exception {
  final String message;
  LocationPermissionDeniedForeverException(this.message);

  @override
  String toString() => message;
}
