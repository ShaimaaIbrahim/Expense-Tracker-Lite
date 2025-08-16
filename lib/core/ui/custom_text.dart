import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final Paint? foreground;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? excludeLine;

  const CustomText(
      this.text, {
        super.key,
        this.style,
        this.align,
        this.maxLines,
        this.overflow,
        this.softWrap,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.letterSpacing,
        this.wordSpacing,
        this.height,
        this.decoration,
        this.fontStyle,
        this.foreground,
        this.textDirection,
        this.locale,
        this.excludeLine,
      });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
      foreground: foreground,
    );

    return Text(
      text,
      style: style ?? defaultStyle,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      strutStyle: excludeLine == true
          ? const StrutStyle(forceStrutHeight: true, height: 1.0)
          : null,
    );
  }
}
