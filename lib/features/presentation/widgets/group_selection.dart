import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CategoriesButtonGroup extends StatefulWidget {
  final List<String> options;
  final void Function(int) onSelect;
  final int initialSelection;

  const CategoriesButtonGroup({
    super.key,
    required this.options,
    required this.onSelect,
    this.initialSelection = 0,
  });

  @override
  State<CategoriesButtonGroup> createState() => _CategoriesButtonGroupState();
}

class _CategoriesButtonGroupState extends State<CategoriesButtonGroup> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: List.generate(
            widget.options.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onSelect(index);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : AppPalette.disabledColor,
                  foregroundColor: selectedIndex == index
                      ? AppPalette.textNegativeColor
                      : AppPalette.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  widget.options[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
