import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final bool filled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final FocusNode? focusNode;
  final bool readOnly;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final StrutStyle? strutStyle;
  final bool showCursor;
  final bool expands;
  final int? errorMaxLines;
  final String? counterText;
  final bool? isDense;
  final double? borderRadius;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? margin;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final Widget? Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final UndoHistoryController? undoController;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor,
    this.filled = false,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.contentPadding,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.focusNode,
    this.readOnly = false,
    this.initialValue,
    this.keyboardAppearance,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.strutStyle,
    this.showCursor = true,
    this.expands = false,
    this.errorMaxLines,
    this.counterText,
    this.isDense,
    this.borderRadius = 8.0,
    this.autofillHints,
    this.margin,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.contextMenuBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.undoController,
  });

  @override
  Widget build(BuildContext context) {
    // final defaultBorder = OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(borderRadius!),
    //   borderSide: BorderSide(color: Colors.grey.shade400),
    // );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: AppColors.grayColor,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          suffixText: suffixText,
          prefix: prefix,
          suffix: suffix,
          filled: filled,
          fillColor: fillColor,
          border: InputBorder.none,
          //border: border ?? defaultBorder,
          //enabledBorder: enabledBorder ?? defaultBorder,
          // focusedBorder: focusedBorder ?? defaultBorder.copyWith(
          //   borderSide: BorderSide(
          //     color: Theme.of(context).colorScheme.primary,
          //     width: 1.5,
          //   ),
          // ),
          // errorBorder: errorBorder ?? defaultBorder.copyWith(
          //   borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          // ),
          // disabledBorder: disabledBorder ?? defaultBorder,
          contentPadding: contentPadding ?? const EdgeInsets.all(16),
          isDense: false,
          counterText: counterText,
          errorMaxLines: errorMaxLines,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          helperStyle: helperStyle,
          errorStyle: errorStyle,
        ),
        obscureText: obscureText,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        style: style,
        validator: validator,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        autofocus: autofocus,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        focusNode: focusNode,
        readOnly: readOnly,
        initialValue: initialValue,
        keyboardAppearance: keyboardAppearance,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        cursorWidth: cursorWidth!,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor ?? Theme.of(context).colorScheme.primary,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        strutStyle: strutStyle,
        showCursor: showCursor,
        expands: expands,
        autofillHints: autofillHints,
        enableInteractiveSelection: enableInteractiveSelection,
        selectionControls: selectionControls,
        // contextMenuBuilder: contextMenuBuilder,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        scribbleEnabled: scribbleEnabled,
        canRequestFocus: canRequestFocus,
        spellCheckConfiguration: spellCheckConfiguration,
        undoController: undoController,
      ),
    );
  }
}
