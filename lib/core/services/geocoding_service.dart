import 'package:ecobin/core/data/services/api_client.dart';

class GeocodingService {
  final ApiClient apiClient;

  GeocodingService({required this.apiClient});

  /// Reverse geocode: Convert coordinates to address
  Future<ReverseGeocodeResult?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await apiClient.post(
        'geocode/reverse',
        data: {'latitude': latitude, 'longitude': longitude},
      );

      if (response.statusCode == 200) {
        return ReverseGeocodeResult.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error in reverseGeocode: $e');
      return null;
    }
  }

  /// Forward geocode: Convert address to coordinates

  Future<ForwardGeocodeResult?> forwardGeocode({
    required String address,
  }) async {
    try {
      final response = await apiClient.post(
        'geocode/forward',
        data: {'address': address},
      );

      if (response.statusCode == 200) {
        return ForwardGeocodeResult.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error in forwardGeocode: $e');
      return null;
    }
  }
}

class ReverseGeocodeResult {
  final String address;
  final AddressDetails? addressDetails;

  ReverseGeocodeResult({required this.address, this.addressDetails});

  factory ReverseGeocodeResult.fromJson(Map<String, dynamic> json) {
    return ReverseGeocodeResult(
      address: json['address'],
      addressDetails: json['addressDetails'] != null
          ? AddressDetails.fromJson(json['addressDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'addressDetails': addressDetails?.toJson()};
  }
}

class AddressDetails {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  AddressDetails({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }

  String get formattedShort {
    final parts = <String>[];
    if (city != null) parts.add(city!);
    if (state != null) parts.add(state!);
    return parts.join(', ');
  }

  String get formattedFull {
    final parts = <String>[];
    if (city != null) parts.add(city!);
    if (state != null) parts.add(state!);
    if (country != null) parts.add(country!);
    return parts.join(', ');
  }
}

class ForwardGeocodeResult {
  final double latitude;
  final double longitude;
  final String address;

  ForwardGeocodeResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory ForwardGeocodeResult.fromJson(Map<String, dynamic> json) {
    return ForwardGeocodeResult(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'address': address};
  }
}
