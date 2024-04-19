import 'package:cps_mobile/core/res/app_media.dart';
import 'package:cps_mobile/core/utils/app_colors.dart';
import 'package:cps_mobile/core/utils/custom_text_style.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/presentation/widgets/user_detail.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final UserEntity user;

  const UserList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showUserDetail(context, user);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: MediaQuery.of(context).size.width,
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
                      style: CustomTextStyle.textExtraLargeSemiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.city ?? 'No City',
                      style: CustomTextStyle.textRegular
                          .copyWith(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showUserDetail(BuildContext context, UserEntity user) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (context) {
        return UserDetail(user: user);
      },
    );
  }
}
