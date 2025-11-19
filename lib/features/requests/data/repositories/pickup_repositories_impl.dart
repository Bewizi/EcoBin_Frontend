import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/requests/data/datasource/pickup_remote_datasource.dart';
import 'package:ecobin/features/requests/domain/pickup.dart';
import 'package:ecobin/features/requests/domain/repository/pickup_repository.dart';

class PickUpRepositoriesImpl implements PickupRepository {
  final PickupRemoteDatasource remoteDatasource;

  PickUpRepositoriesImpl({required this.remoteDatasource});

  @override
  Future<Pickup> getPickup() async {
    try {
      final pickup = await remoteDatasource.getPickup();
      return pickup;
    } catch (e) {
      throw ServerException('Failed to get pickup: $e');
    }
  }

  @override
  Future<Pickup> createPickup({
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
    String? additionalNote,
  }) async {
    try {
      final pickup = await remoteDatasource.createPickup(
        userId: userId,
        address: address,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
      );
      return pickup;
    } catch (e) {
      throw ServerException('Failed to create pickup: $e');
    }
  }

  @override
  Future<Pickup> getPickupById(String $id) async {
    try {
      final pickup = await remoteDatasource.getPickupById($id);
      return pickup;
    } catch (e) {
      throw ServerException('Failed to get pickup by id: $e');
    }
  }
}
