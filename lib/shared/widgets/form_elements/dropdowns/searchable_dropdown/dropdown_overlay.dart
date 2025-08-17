import 'package:flutter/material.dart';
import 'searchable_dropdown.dart';

class DropdownOverlay extends StatefulWidget {
  final List<String> filteredItems;
  final String? selectedValue;
  final Function(String) onItemSelected;
  final VoidCallback onOutsideTap;
  final Animation<double> heightAnimation;
  final List<DropdownCategory>? categories;
  final String? selectedCategory;
  final Function(String?)? onCategoryChanged;

  const DropdownOverlay({
    super.key,
    required this.filteredItems,
    required this.selectedValue,
    required this.onItemSelected,
    required this.onOutsideTap,
    required this.heightAnimation,
    this.categories,
    this.selectedCategory,
    this.onCategoryChanged,
  });

  @override
  State<DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<DropdownOverlay>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    if (widget.categories != null && widget.categories!.isNotEmpty) {
      _tabController = TabController(
        length: widget.categories!.length + 1, // +1 for "All" tab
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.heightAnimation,
      builder: (context, child) {
        final hasCategories = widget.categories != null && widget.categories!.isNotEmpty;
        final maxHeight = hasCategories ? 250.0 : 200.0;
        
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(0),
          child: ClipRect(
            child: Container(
              height: widget.heightAnimation.value * maxHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: widget.heightAnimation.value == 0
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        if (hasCategories && _tabController != null)
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              isScrollable: false,
                              dividerColor: Colors.transparent,
                              labelColor: Theme.of(context).colorScheme.primary,
                              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(0),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onTap: (index) {
                                if (index == 0) {
                                  widget.onCategoryChanged?.call(null); // "All" tab
                                } else {
                                  widget.onCategoryChanged?.call(widget.categories![index - 1].name);
                                }
                              },
                              tabs: [
                                const Tab(text: 'All'),
                                ...widget.categories!.map((category) => Tab(text: category.name)),
                              ],
                            )
                          ),
                        
                        // Items list
                        Expanded(
                          child: widget.filteredItems.isEmpty
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
                                  itemCount: widget.filteredItems.length,
                                  itemBuilder: (context, index) {
                                    final item = widget.filteredItems[index];
                                    return InkWell(
                                      onTap: () => widget.onItemSelected(item),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.selectedValue == item
                                              ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)
                                              : null,
                                        ),
                                        child: Text(
                                          item,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: widget.selectedValue == item
                                                ? Theme.of(context).colorScheme.primary
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}