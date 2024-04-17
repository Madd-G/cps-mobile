import 'package:cps_mobile/core/res/app_media.dart';
import 'package:cps_mobile/core/utils/app_colors.dart';
import 'package:cps_mobile/core/utils/custom_text_style.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final UserEntity user;

  const UserList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppMedia.avatar),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.name ?? 'No Name',
                    style: CustomTextStyle.textBigSemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user.address ?? 'No Address',
                    style: CustomTextStyle.textSmallRegular
                        .copyWith(color: AppColors.greyColor),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
