import 'package:flutter/material.dart';

class PasswordVisible extends StatelessWidget {
  final bool isObscured;
  final VoidCallback? onToggle;

  const PasswordVisible({
    super.key,
    required this.isObscured,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Icon(
        isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      ),
    );
  }
}
