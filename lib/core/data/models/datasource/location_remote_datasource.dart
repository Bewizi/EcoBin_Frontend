import 'package:ecobin/core/data/models/location_model.dart';
import 'package:ecobin/core/data/services/api_client.dart';

abstract class LocationRemoteDatasource {
  Future<List<LocationModel>> getLocations();
  Future<LocationModel> createLocation({
    required String address,
    double? latitude,
    double? longitude,
    bool? isDefault,
  });
  Future<LocationModel> getLocation(String id);
  Future<LocationModel> updateLocation({
    required String id,
    String? address,
    double? latitude,
    double? longitude,
    bool? isDefault,
  });
  Future<void> deleteLocation(String id);
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final ApiClient apiClient;

  LocationRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<LocationModel>> getLocations() async {
    try {
      final response = await apiClient.get('locations');
      final List<dynamic> locationsJson = response.data['locations'] as List;
      return locationsJson
          .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocationModel> createLocation({
    required String address,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) async {
    try {
      final Map<String, dynamic> data = {'address': address};

      if (latitude != null) data['latitude'] = latitude;
      if (longitude != null) data['longitude'] = longitude;
      if (isDefault != null) data['is_default'] = isDefault;

      final response = await apiClient.post('locations', data: data);
      return LocationModel.fromJson(
        response.data['location'] as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocationModel> getLocation(String id) async {
    try {
      final response = await apiClient.get('locations/$id');
      return LocationModel.fromJson(
        response.data['location'] as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocationModel> updateLocation({
    required String id,
    String? address,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) async {
    try {
      final Map<String, dynamic> data = {};

      if (address != null) data['address'] = address;
      if (latitude != null) data['latitude'] = latitude;
      if (longitude != null) data['longitude'] = longitude;
      if (isDefault != null) data['is_default'] = isDefault;

      final response = await apiClient.put('locations/$id', data: data);
      return LocationModel.fromJson(
        response.data['location'] as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteLocation(String id) async {
    try {
      await apiClient.delete('locations/$id');
    } catch (e) {
      rethrow;
    }
  }
}
