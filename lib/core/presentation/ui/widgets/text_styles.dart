import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader(
    this.text, {
    super.key,
    this.fontSize = 24,
    this.color,
    this.fontWeight,
    this.textAlign,
  });

  final String? text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final scaler = MediaQuery.textScalerOf(context);
    final scaledSize = scaler.scale(fontSize);
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        fontSize: scaledSize,
        color: color ?? defaultColor,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextRegular extends StatelessWidget {
  const TextRegular(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.color,
    this.fontWeight,
    this.textAlign,
  });

  final String? text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final scaledSize = scaler.scale(fontSize);

    final defaultColor = Theme.of(context).colorScheme.onSurfaceVariant;
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        fontSize: scaledSize,
        color: color ?? defaultColor,
        fontWeight: fontWeight,
      ),
    );
  }
}

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.spans,
    this.textStyle,
    this.text,
    this.color,
    this.textAlign,
    this.fontSize = 16,
  });

  final List<InlineSpan> spans;
  final TextStyle? textStyle;
  final String? text;
  final Color? color;
  final TextAlign? textAlign;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text ?? '',
        style: TextStyle(color: color, fontSize: fontSize).merge(textStyle),
        children: spans,
      ),
      textAlign: textAlign,
    );
  }
}
