import 'package:flutter/material.dart';

class DropdownOverlay extends StatelessWidget {
  final List<String> filteredItems;
  final String? selectedValue;
  final Function(String) onItemSelected;
  final VoidCallback onOutsideTap;

  const DropdownOverlay({
    super.key,
    required this.filteredItems,
    required this.selectedValue,
    required this.onItemSelected,
    required this.onOutsideTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(
          //   color: Theme.of(context).colorScheme.onSurface,
          //   width: 1,
          // ),
        ),
        child: filteredItems.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No items found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return InkWell(
                    onTap: () => onItemSelected(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: selectedValue == item
                            ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)
                            : null,
                      ),
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selectedValue == item
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}