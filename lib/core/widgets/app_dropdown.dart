import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_radius.dart';

/// Styled dropdown field.
class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;

  const AppDropdown({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.label),
          const SizedBox(height: 6),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: NelsonColors.textTertiary),
          style: AppTypography.body.copyWith(color: NelsonColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: AppRadius.inputRadius,
              borderSide: const BorderSide(color: NelsonColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.inputRadius,
              borderSide: const BorderSide(color: NelsonColors.border),
            ),
          ),
          dropdownColor: NelsonColors.surface,
        ),
      ],
    );
  }
}
