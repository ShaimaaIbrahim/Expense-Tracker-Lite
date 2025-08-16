

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final Color? textColor;
  final Color? hoveColor;
  final FontWeight? textWeight;
  final double? textSize;
  final double? elevation;
  final double? gapLeadingText;
  final Widget? child;
  final double width;
  final double height;
  final Color borderColor;
  final Color? shadowColor;
  final Color? overlayColor;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.radius,
    this.contentPadding,
    this.color,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.width= 248.0,
    this.height=44.0,
    this.borderColor =  AppColors.secondaryColor,
    this.shadowColor,
    this.overlayColor,
  })  : child = null,
        gapLeadingText = null,
        super(key: key);

  const CustomButton.icon({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.child,
    this.gapLeadingText = 10,
    this.radius,
    this.contentPadding,
    this.color,
    this.shadowColor,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.width= 500.0,
    this.height=100.0,
    this.overlayColor,
  }) :this.borderColor=AppColors.secondaryColor, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TextButton(
        onPressed: onPressed,
        clipBehavior: Clip.antiAlias,
        style:Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all(elevation??0),
              overlayColor: MaterialStateProperty.all(overlayColor),
              shadowColor: MaterialStateProperty.all(shadowColor??AppColors.lightBackground),
              backgroundColor: MaterialStateProperty.all(color??AppColors.lightBackground),
              shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: borderColor)))
          ),
        child: CustomText(
          text,
          color: textColor ?? Colors.white,
          maxLines: 1,
          fontSize: textSize,
          fontWeight: textWeight?? FontWeight.w600
        )
      ),
    );
  }
}
