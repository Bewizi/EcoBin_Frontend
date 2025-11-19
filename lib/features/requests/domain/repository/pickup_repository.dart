import 'package:ecobin/features/requests/domain/pickup.dart';

abstract class PickupRepository {
  Future<List<Pickup>> getPickup();

  Future<Pickup> createPickup({
    required String userId,
    required String address,
    required String pickupDate,
    required String pickupTime,
    String? additionalNote,
  });

  Future<Pickup> getPickupById(String $id);
}
