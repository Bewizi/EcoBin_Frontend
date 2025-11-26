import 'package:ecobin/features/requests/domain/waste_categories.dart';
import 'package:ecobin/features/requests/data/model/waste_item_model.dart';

class WasteCategoryModel extends WasteCategories {
  const WasteCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.items,
  });

  factory WasteCategoryModel.fromJson(Map<String, dynamic> json) {
    final itemsJson =
        json['waste_items'] ?? json['wasteItems'] ?? json['items'] ?? [];

    return WasteCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      items: (itemsJson as List<dynamic>)
          .map((e) => WasteItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'wasteItems': items.map((i) => (i as WasteItemModel).toJson()).toList(),
    };
  }

  factory WasteCategoryModel.fromEntity(WasteCategories category) {
    return WasteCategoryModel(
      id: category.id,
      name: category.name,
      slug: category.slug,
      items: category.items.map((e) => WasteItemModel.fromEntity(e)).toList(),
    );
  }
}
