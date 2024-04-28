import 'package:cps_mobile/core/res/app_media.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/presentation/bloc/update_user_bloc/update_user_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UserUpdateSheet extends StatefulWidget {
  const UserUpdateSheet({super.key, required this.user});

  final UserEntity user;

  @override
  State<UserUpdateSheet> createState() => _UserUpdateSheetState();
}

class _UserUpdateSheetState extends State<UserUpdateSheet> {
  late TextEditingController? nameController;
  late TextEditingController? emailController;
  late TextEditingController? addressController;
  late TextEditingController? cityController;
  late TextEditingController? phoneNumberController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    addressController = TextEditingController(text: widget.user.address);
    cityController = TextEditingController(text: widget.user.city);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    addressController?.dispose();
    cityController?.dispose();
    phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateFormKey = GlobalKey<FormState>();
    final Size size = MediaQuery.of(context).size;
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
                    UpdateUserItem(title: "Name", controller: nameController!),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    UpdateUserItem(
                        title: "Email", controller: emailController!),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    UpdateUserItem(
                        title: "Alamat", controller: addressController!),
                    const Divider(
                        color: AppColors.borderPrimary, thickness: 1.0),
                    UpdateUserItem(title: "Kota", controller: cityController!),
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
                    Container(
                      constraints: BoxConstraints(maxWidth: size.width * 0.6),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          enableInteractiveSelection: true,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          style: CustomTextStyle.textBigBold
                              .copyWith(color: AppColors.greyColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                // if (updateFormKey.currentState!.validate()) {
                  UserModel user = UserModel(
                    name: nameController?.text,
                    email: emailController?.text,
                    address: addressController?.text,
                    city: cityController?.text,
                    phoneNumber: phoneNumberController?.text,
                  );

                  context.read<UpdateUserBloc>().add(
                      EventUpdateUser(userId: widget.user.id!, user: user));
                  Get.back();
                  Get.back();
                // }

                nameController?.clear();
                addressController?.clear();
                emailController?.clear();
                phoneNumberController?.clear();
                cityController?.clear();
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
        return UserDetail(user: user);
      },
    );
  }
}
