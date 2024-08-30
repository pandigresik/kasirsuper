import 'package:flutter/material.dart';
import 'package:kasirsuper/core/core.dart';

class RegularText extends StatelessWidget {
  const RegularText(
    this.text, {
    super.key,
    this.textAlign,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  factory RegularText.semiBold(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return RegularText(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ).merge(style),
    );
  }

  factory RegularText.medium(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return RegularText(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ).merge(style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.theme.textTheme.bodyMedium;

    return Text(
      text,
      style: baseStyle?.merge(style),
      textAlign: textAlign,
    );
  }
}
