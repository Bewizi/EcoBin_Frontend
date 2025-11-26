import 'package:ecobin/features/requests/domain/waste_item.dart';

class WasteItemModel extends WasteItem {
  const WasteItemModel({required super.id, required super.name});

  factory WasteItemModel.fromJson(Map<String, dynamic> json) {
    return WasteItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory WasteItemModel.fromEntity(WasteItem item) {
    return WasteItemModel(id: item.id, name: item.name);
  }
}
