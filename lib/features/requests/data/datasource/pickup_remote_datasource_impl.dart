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
    // TODO: implement deletePickup
    throw UnimplementedError();
  }

  @override
  Future<PickupModel> getPickup() async {
    try {
      final response = await apiClient.get('/pickups');
      return PickupModel.fromJson(response.data);
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
    // TODO: implement updatePickup
    throw UnimplementedError();
  }
}
