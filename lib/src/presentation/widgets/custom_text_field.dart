import 'package:cps_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
    this.inputBorder,
    this.maxLines = 1,
    this.validationErrorMessage = "This field is required",
    ValueChanged<String>? onChanged,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool filled;
  final int maxLines;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final InputBorder? inputBorder;
  final String? validationErrorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CustomTextStyle.textMedium.copyWith(
        color: AppColors.blackColor,
      ),
      controller: controller,
      cursorColor: Colors.grey,
      onChanged: (newValue) {
        controller?.text = newValue;
      },
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty || value == '') {
                return validationErrorMessage;
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixText: "      ",
        constraints: const BoxConstraints(maxWidth: 450.0),
        border: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
        enabledBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: AppColors.greyColor,
                width: 1.0,
              ),
            ),
        focusedBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        filled: true,
        fillColor: AppColors.whiteColor,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? CustomTextStyle.textRegular,
      ),
    );
  }
}
