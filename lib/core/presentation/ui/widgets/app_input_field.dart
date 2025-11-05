import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.hintText,
    this.controller,
    this.title,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefix,
    this.suffix,
    this.prefixIcons,
    this.showTitle = true,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? title;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final Widget? prefix;
  final Widget? suffix;
  final bool showTitle;
  final Widget? prefixIcons;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  Widget _buildTextFormField(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      onChanged: onChanged,
      validator: (value) => validator?.call(value),

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kFrenchGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kFrenchGray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kError),
        ),

        errorMaxLines: 3,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.kSlateGray,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefix: prefix,
        suffixIcon: suffix,
        prefixIcon: prefixIcons,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[TextRegular(title, color: AppColors.kBlack)],
        const SizedBox(height: 12),
        _buildTextFormField(context),
      ],
    );
  }
}
