import 'package:flutter/material.dart';
import 'dropdown_overlay.dart';

class DropdownCategory {
  final String name;
  final List<String> items;

  const DropdownCategory({
    required this.name,
    required this.items,
  });
}

class SearchableDropdown extends StatefulWidget {
  final List<String> dropdownItems;
  final String title;
  final String hint;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final List<DropdownCategory>? categories;

  const SearchableDropdown({
    super.key,
    required this.dropdownItems,
    required this.title,
    required this.hint,
    this.value,
    this.onChanged,
    this.categories,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> 
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredItems = [];
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry;
  String? _selectedCategory;
  
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.dropdownItems;
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    initializeTextInputWithDropdownValue();
  }

  void initializeTextInputWithDropdownValue() {
    if (widget.value != null) {
      _searchController.text = widget.value!;
    }
  }

  void updateTextInputOnDropdownValueChange(SearchableDropdown oldWidget) {
    if (widget.value != oldWidget.value) {
      if (widget.value != null) {
        _searchController.text = widget.value!;
      } else {
        _searchController.text = '';
      }
    }
  }

  void updateFilteredItemsIfDropdownItemsChange(SearchableDropdown oldWidget) {
    if (widget.dropdownItems != oldWidget.dropdownItems) {
      _filteredItems = widget.dropdownItems
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
      _updateOverlay();
    }
  }

  @override
  void didUpdateWidget(SearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    updateTextInputOnDropdownValueChange(oldWidget);
    updateFilteredItemsIfDropdownItemsChange(oldWidget);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _focusNode.removeListener(_onFocusChanged);
    _searchController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _applyFilters();
    });
    _updateOverlay();
  }

  void _applyFilters() {
    List<String> baseItems = widget.dropdownItems;
    
    // Get items of selected category, so they can be filtered.
    if (widget.categories != null && _selectedCategory != null) {
      final category = widget.categories!.firstWhere(
        (cat) => cat.name == _selectedCategory,
        orElse: () => DropdownCategory(name: 'All', items: widget.dropdownItems),
      );
      baseItems = category.items;
    }
    
    // Apply search filter
    if (_searchController.text.isEmpty) {
      _filteredItems = baseItems;
    } else {
      _filteredItems = baseItems
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    }
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _searchController.clear();
      _selectedCategory = null;
      _applyFilters();
      _showOverlay();
    } else {
      _hideOverlay();
      _validateAndResetText();
    }
  }

  void _onCategoryChanged(String? category) {
    setState(() {
      _selectedCategory = category;
      _applyFilters();
    });
    _updateOverlay();
  }

  /// If the current text is not a valid option, reset to the current value or clear
  void _validateAndResetText() {
    if (!widget.dropdownItems.contains(_searchController.text)) {
      if (widget.value != null && widget.dropdownItems.contains(widget.value!)) {
        _searchController.text = widget.value!;
      } else {
        _searchController.text = '';
      }
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    
    setState(() {
      _isExpanded = true;
    });

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _hideOverlay() {
    _animationController.reverse().then((_) {
      _removeOverlay();
    });
    setState(() {
      _isExpanded = false;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_overlayEntry != null) {
          _overlayEntry!.markNeedsBuild();
        }
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _focusNode.unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height,
                width: size.width,
                child: GestureDetector(
                  onTap: () {},
                  child: DropdownOverlay(
                    filteredItems: _filteredItems,
                    selectedValue: widget.value,
                    onItemSelected: _selectItem,
                    onOutsideTap: () => _focusNode.unfocus(),
                    heightAnimation: _heightAnimation,
                    categories: widget.categories,
                    selectedCategory: _selectedCategory,
                    onCategoryChanged: _onCategoryChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectItem(String item) {
    _searchController.text = item;
    widget.onChanged?.call(item);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 53,
          child: TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2,
                ),
              ),
              hintText: widget.value ?? widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_isExpanded) {
                    _focusNode.unfocus();
                  } else {
                    _focusNode.requestFocus();
                  }
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}