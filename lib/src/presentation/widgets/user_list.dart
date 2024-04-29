import 'package:cps_mobile/core/res/app_media.dart';
import 'package:cps_mobile/core/utils/utils.dart';
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
        FocusManager.instance.primaryFocus?.unfocus();
        showUserDetail(context, user);
      },
      child: Container(
        // color: AppColors.borderSecondary,
        margin: const EdgeInsets.only(bottom: 8),
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
            const Divider(color: AppColors.borderSecondary),
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
