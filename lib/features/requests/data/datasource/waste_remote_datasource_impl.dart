import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/requests/data/datasource/waste_remote_datasource.dart';
import 'package:ecobin/features/requests/data/model/waste_category_model.dart';

class WasteRemoteDataSourceImpl implements WasteRemoteDatasource {
  final ApiClient apiClient;

  WasteRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<WasteCategoryModel>> getWasteTypes() async {
    try {
      // backend returns { data: [ ...categories ] }
      final response = await apiClient.get('waste-categories');

      final List<dynamic> list = response.data['data'] as List<dynamic>;

      return list
          .map((e) => WasteCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WasteCategoryModel> getWasteCategoryById(String id) async {
    try {
      // backend returns { data: { ...category } }
      final response = await apiClient.get('waste-categories/$id');

      final Map<String, dynamic> data =
          response.data['data'] as Map<String, dynamic>;

      return WasteCategoryModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
