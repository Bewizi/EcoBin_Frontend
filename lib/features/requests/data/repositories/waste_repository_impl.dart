import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/requests/data/datasource/waste_remote_datasource.dart';
import 'package:ecobin/features/requests/domain/waste_categories.dart';
import 'package:ecobin/features/requests/domain/repository/waste_type_repository.dart';

class WasteTypeRepositoryImpl implements WasteTypeRepository {
  final WasteRemoteDatasource remoteDatasource;

  WasteTypeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<WasteCategories>> getWasteTypes() async {
    try {
      final types = await remoteDatasource.getWasteTypes();
      return types;
    } catch (e) {
      throw ServerException('Failed to fetch waste types: $e');
    }
  }

  @override
  Future<WasteCategories> getWasteCategoryById(String id) async {
    try {
      final types = await remoteDatasource.getWasteCategoryById(id);
      final category = types;
      return category;
    } catch (e) {
      throw ServerException('Failed to fetch waste category by id: $e');
    }
  }
}
