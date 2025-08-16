import 'package:expense_tracker_lite/core/constants/app_assets.dart';
import 'package:expense_tracker_lite/core/ui/custom_text.dart';
import 'package:expense_tracker_lite/data/models/category_model.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? hintText;
  final String? labelText;
  final ValueChanged<T?> onChanged;
  final List<DropdownMenuItem<T>> Function(BuildContext)? itemBuilder;
  final String Function(T)? displayText;
  final bool isExpanded;
  final EdgeInsetsGeometry? padding;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final TextStyle? textStyle;
  final int? elevation;
  final Widget? icon;
  final Color? iconEnabledColor;
  final double? dropdownWidth;
  final double? dropdownHeight;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.labelText,
    this.itemBuilder,
    this.displayText,
    this.isExpanded = true,
    this.padding,
    this.border,
    this.fillColor,
    this.filled = false,
    this.textStyle,
    this.elevation,
    this.icon,
    this.iconEnabledColor,
    this.dropdownWidth,
    this.dropdownHeight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dropdownWidth,
      height: dropdownHeight,
      decoration: BoxDecoration(
        color: AppColors.grayColor,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: itemBuilder != null
            ? itemBuilder!(context)
            : items.map((item) => DropdownMenuItem<T>(
          value: item,
          child: CustomText(
            displayText != null ? displayText!(item) : item.toString(),
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        )).toList(),
        onChanged: onChanged,
        isExpanded: false,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          fillColor: fillColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
        ),
        icon: icon ??  Image.asset(AppAssets.downArrow, color: AppColors.secondaryText, scale: 0.5),
        iconEnabledColor: iconEnabledColor,
        elevation: elevation ?? 8,
        style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
        hint: hintText != null
            ? Text(
          hintText!,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        )
            : null,
      )
    );
  }
}