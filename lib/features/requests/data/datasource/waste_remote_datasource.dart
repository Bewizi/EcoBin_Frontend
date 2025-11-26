import 'package:ecobin/features/requests/data/model/waste_category_model.dart';

abstract class WasteRemoteDatasource {
  Future<List<WasteCategoryModel>> getWasteTypes();

  Future<WasteCategoryModel> getWasteCategoryById(String id);
}
