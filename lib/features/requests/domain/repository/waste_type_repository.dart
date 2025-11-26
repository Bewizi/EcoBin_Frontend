import 'package:ecobin/features/requests/domain/waste_categories.dart';

abstract class WasteTypeRepository {
  Future<List<WasteCategories>> getWasteTypes();

  Future<WasteCategories> getWasteCategoryById(String id);
}
