import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Debounced search bar.
class AppSearchBar extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilter;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.hint = 'Search...',
    required this.onChanged,
    this.onFilterTap,
    this.showFilter = false,
    this.controller,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: AppConstants.searchDebounceMs),
      () => widget.onChanged(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: NelsonColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NelsonColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 20, color: NelsonColors.textTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              style: AppTypography.body,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTypography.body.copyWith(color: NelsonColors.textTertiary),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged('');
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.close, size: 18, color: NelsonColors.textTertiary),
              ),
            ),
          if (widget.showFilter) ...[
            Container(
              width: 1,
              height: 24,
              color: NelsonColors.border,
            ),
            GestureDetector(
              onTap: widget.onFilterTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.tune, size: 20, color: NelsonColors.primaryBlue),
              ),
            ),
          ] else
            const SizedBox(width: 12),
        ],
      ),
    );
  }
}
