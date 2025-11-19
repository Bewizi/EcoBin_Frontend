import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/requests/data/datasource/pickup_remote_datasource.dart';
import 'package:ecobin/features/requests/data/model/pickup_model.dart';

class PickupRemoteDataSourceImpl implements PickupRemoteDatasource {
  final ApiClient apiClient;

  PickupRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<PickupModel> createPickup({
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
    String? additionalNote,
  }) async {
    try {
      final response = await apiClient.post(
        '/pickups',
        data: {
          'userId': userId,
          'address': address,
          'pickupDate': pickupDate,
          'pickupTime': pickupTime,
          'additionalNote': additionalNote,
        },
      );
      return PickupModel.fromJson(response.data['pickup']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PickupModel> deletePickup(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PickupModel>> getPickup() async {
    try {
      final response = await apiClient.get('/pickups');

      final List<dynamic> data = response.data['pickups'];

      return data.map((json) => PickupModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PickupModel> getPickupById(String id) async {
    try {
      final response = await apiClient.get('/pickups/$id');
      return PickupModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PickupModel> updatePickup({
    required String id,
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
  }) {
    throw UnimplementedError();
  }
}
