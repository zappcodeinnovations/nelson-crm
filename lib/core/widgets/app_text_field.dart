import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Styled text input field.
class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.inputFormatters,
    this.focusNode,
    this.contentPadding,
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
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          style: AppTypography.body.copyWith(color: NelsonColors.black),
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            contentPadding: contentPadding,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20, color: NelsonColors.black)
                : prefix,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(suffixIcon, size: 20, color: NelsonColors.black),
                  )
                : suffix,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
