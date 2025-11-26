import 'package:equatable/equatable.dart';
import 'package:ecobin/features/requests/domain/waste_item.dart';

class WasteCategories extends Equatable {
  final String id;
  final String name;
  final String slug;
  final List<WasteItem> items;

  const WasteCategories({
    required this.id,
    required this.name,
    required this.slug,
    this.items = const [],
  });

  @override
  List<Object> get props => [name, slug, ...items];

  WasteCategories copyWith({
    String? id,
    String? name,
    String? slug,
    List<WasteItem>? items,
  }) {
    return WasteCategories(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      items: items ?? this.items,
    );
  }

  factory WasteCategories.fromJson(Map<String, dynamic> json) {
    // Accept different possible keys coming from API responses:
    // - snake_case: 'waste_items'
    // - camelCase: 'wasteItems'
    // - fallback: 'items'
    final itemsJson =
        json['waste_items'] ?? json['wasteItems'] ?? json['items'] ?? [];

    return WasteCategories(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      items: (itemsJson as List<dynamic>)
          .map((e) => WasteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
