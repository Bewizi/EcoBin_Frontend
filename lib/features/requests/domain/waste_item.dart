import 'package:equatable/equatable.dart';

class WasteItem extends Equatable {
  final String id;
  final String name;

  const WasteItem({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];

  WasteItem copyWith({String? id, String? name}) {
    return WasteItem(id: id ?? this.id, name: name ?? this.name);
  }

  factory WasteItem.fromJson(Map<String, dynamic> json) {
    return WasteItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}
