import 'package:cps_mobile/core/res/app_media.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: RoundedContainer(
                radius: 90,
                height: 6.0,
                width: 120.0,
                containerColor: AppColors.borderPrimary,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(child: Image.asset(AppMedia.avatar, fit: BoxFit.fill)),
            const SizedBox(height: 20.0),
            RoundedContainer(
              radius: 8.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Column(
                  children: [
                    DetailUserItem(
                      title: "Nama",
                      value: user.name!,
                    ),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    DetailUserItem(
                      title: "Email",
                      value: user.email!,
                    ),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    DetailUserItem(
                      title: "Alamat",
                      value: user.address!,
                    ),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    DetailUserItem(
                      title: "Kota",
                      value: user.city!,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            RoundedContainer(
              containerColor: AppColors.backgroundColor,
              radius: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nomor Handphone',
                      style: CustomTextStyle.textBigMedium
                          .copyWith(color: AppColors.blackColor),
                    ),
                    Text(
                      user.phoneNumber!,
                      style: CustomTextStyle.textBigMedium
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Hapus user",
                              style: CustomTextStyle.textLargeSemiBold,
                            ),
                            content: Text(
                                "Apakah anda yakin ingin menghapus user ${user.name} ?"),
                            actions: [
                              GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Text('Tutup')),
                              const SizedBox(width: 5.0),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserBloc>()
                                      .add(DeleteUserEvent(userId: user.id!));
                                  Get.back();
                                  Get.back();
                                },
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(color: AppColors.redColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: RoundedContainer(
                      radius: 8.0,
                      borderWidth: 1.5,
                      borderColor: AppColors.borderPrimary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'Hapus User',
                            style: CustomTextStyle.textLargeMedium
                                .copyWith(color: AppColors.redColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showUserUpdate(context, user);
                    },
                    child: RoundedContainer(
                      radius: 8.0,
                      borderWidth: 1.5,
                      borderColor: AppColors.borderPrimary,
                      containerColor: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'Update User',
                            style: CustomTextStyle.textLargeMedium
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showUserUpdate(BuildContext context, UserEntity user) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (context) {
        return UserUpdateSheet(user: user);
      },
    );
  }
}
