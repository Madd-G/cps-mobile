import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.validationErrorMessage,
    required this.textInputType,
  });

  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final String? validationErrorMessage;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText,
            style: CustomTextStyle.textMedium
                .copyWith(color: AppColors.blackColor, letterSpacing: -0.01)),
        const SizedBox(height: 4.0),
        CustomTextField(
          validationErrorMessage: '❗$validationErrorMessage',
          controller: controller,
          hintText: hintText,
          keyboardType: textInputType,
          overrideValidator: false,
          hintStyle: CustomTextStyle.textRegular
              .copyWith(color: AppColors.whiteColor, letterSpacing: -0.01),
          // onChanged: (String value) {},
        ),
      ],
    );
  }
}
