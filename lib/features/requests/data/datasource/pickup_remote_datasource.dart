import 'package:ecobin/features/requests/data/model/pickup_model.dart';

abstract class PickupRemoteDatasource {
  Future<PickupModel> createPickup({
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
  });

  Future<PickupModel> getPickup();

  Future<PickupModel> getPickupById(String id);

  Future<PickupModel> updatePickup({
    required String id,
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
  });

  Future<PickupModel> deletePickup(String id);
}
