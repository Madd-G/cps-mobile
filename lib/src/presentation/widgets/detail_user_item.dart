import 'package:cps_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';

class DetailUserItem extends StatelessWidget {
  const DetailUserItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomTextStyle.textBigMedium
              .copyWith(color: AppColors.blackColor),
        ),
        Text(
          value,
          style: CustomTextStyle.textBigMedium
              .copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
