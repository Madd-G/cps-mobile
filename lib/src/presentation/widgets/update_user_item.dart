import 'package:cps_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';

class UpdateUserItem extends StatelessWidget {
  const UpdateUserItem({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              CustomTextStyle.textBigMedium.copyWith(color: AppColors.blackColor),
        ),
        const SizedBox(width: 50.0),
        Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.6),
          child: IntrinsicWidth(
            child: TextFormField(
              enableInteractiveSelection: true,
              controller: controller,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: CustomTextStyle.textBigMedium
                  .copyWith(color: AppColors.greyColor),
            ),
          ),
        ),
      ],
    );
  }
}
