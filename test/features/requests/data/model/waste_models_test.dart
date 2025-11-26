import 'package:ecobin/features/requests/data/model/waste_category_model.dart';
import 'package:ecobin/features/requests/data/model/waste_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Waste models', () {
    test('WasteItemModel fromJson/toJson roundtrip', () {
      final json = {'id': '123', 'name': 'Plastic bottle'};

      final model = WasteItemModel.fromJson(json);

      expect(model.id, '123');
      expect(model.name, 'Plastic bottle');
      expect(model.toJson(), json);
    });

    test('WasteCategoryModel parses nested items', () {
      final json = {
        'name': 'Recyclables',
        'slug': 'recyclables',
        'wasteItems': [
          {'id': '1', 'name': 'Plastic bottles'},
          {'id': '2', 'name': 'Glass bottles'},
        ],
      };

      final model = WasteCategoryModel.fromJson(json);

      expect(model.name, 'Recyclables');
      expect(model.slug, 'recyclables');
      expect(model.items.length, 2);
      expect(model.items.first.name, 'Plastic bottles');
    });

    test('WasteCategoryModel parses nested items with snake_case key', () {
      final json = {
        'name': 'Household',
        'slug': 'household',
        'waste_items': [
          {'id': '1', 'name': 'Food wrappers'},
          {'id': '2', 'name': 'Used tissues'},
        ],
      };

      final model = WasteCategoryModel.fromJson(json);

      expect(model.name, 'Household');
      expect(model.slug, 'household');
      expect(model.items.length, 2);
      expect(model.items.first.name, 'Food wrappers');
    });
  });
}
