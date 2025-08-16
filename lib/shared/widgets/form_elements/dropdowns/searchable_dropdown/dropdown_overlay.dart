import 'package:flutter/material.dart';

class DropdownOverlay extends StatelessWidget {
  final List<String> filteredItems;
  final String? selectedValue;
  final Function(String) onItemSelected;
  final VoidCallback onOutsideTap;
  final Animation<double> heightAnimation;

  const DropdownOverlay({
    super.key,
    required this.filteredItems,
    required this.selectedValue,
    required this.onItemSelected,
    required this.onOutsideTap,
    required this.heightAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heightAnimation,
      builder: (context, child) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(0),
          child: ClipRect(
            child: Container(
              height: heightAnimation.value * 200, // Animate to max height of 200
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: heightAnimation.value == 0
                  ? const SizedBox.shrink()
                  : filteredItems.isEmpty
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
          ),
        );
      },
    );
  }
}