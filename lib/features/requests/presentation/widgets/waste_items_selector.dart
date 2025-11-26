import 'package:ecobin/features/requests/domain/waste_item.dart';
import 'package:flutter/material.dart';

class WasteItemsSelector extends StatefulWidget {
  final List<WasteItem> items;
  final ValueChanged<List<int>>? onSelectionChanged;

  const WasteItemsSelector({
    super.key,
    required this.items,
    this.onSelectionChanged,
  });

  @override
  State<WasteItemsSelector> createState() => _WasteItemsSelectorState();
}

class _WasteItemsSelectorState extends State<WasteItemsSelector> {
  List<bool> _checked = [];

  @override
  void initState() {
    super.initState();
    _checked = List.generate(widget.items.length, (_) => false);
  }

  @override
  void didUpdateWidget(covariant WasteItemsSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _checked = List.generate(widget.items.length, (_) => false);
    }
  }

  void _onChanged(int index, bool v) {
    setState(() {
      _checked[index] = v;
    });
    widget.onSelectionChanged?.call(
      _checked.asMap().entries.where((e) => e.value).map((e) => e.key).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // defensive: ensure items != null and length agrees with _checked
    if (_checked.length != widget.items.length) {
      // recover the checked list instead of crashing
      _checked = List.generate(widget.items.length, (_) => false);
    }

    return Column(
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];

        return Row(
          children: [
            CheckboxTheme(
              data: const CheckboxThemeData(shape: CircleBorder()),
              child: Checkbox(
                checkColor: Theme.of(context).colorScheme.onPrimary,
                value: _checked[index],
                onChanged: (v) => _onChanged(index, v ?? false),
              ),
            ),

            const SizedBox(width: 8),

            // label
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      }),
    );
  }
}
