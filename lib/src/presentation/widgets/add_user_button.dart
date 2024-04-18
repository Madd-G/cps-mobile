import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserButton extends StatefulWidget {
  const AddUserButton({super.key});

  @override
  State<AddUserButton> createState() => _AddUserButtonState();
}

class _AddUserButtonState extends State<AddUserButton> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        if (state is UserListLoaded || state is UserListFilteredLoaded) {
          return FloatingActionButton.extended(
            foregroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(360.0))),
            onPressed: () {
              showAddProductForm(context);
            },
            label: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 11.5, bottom: 8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.add,
                      size: 32,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text("User",
                      style: CustomTextStyle.textLargeMedium
                          .copyWith(color: AppColors.whiteColor)),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<dynamic> showAddProductForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: RoundedContainer(
                      radius: 90,
                      height: 6.0,
                      width: 120.0,
                      containerColor: AppColors.backgroundColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: Text('Tambah User',
                        style: CustomTextStyle.textLargeMedium
                            .copyWith(color: AppColors.blackColor)),
                  ),
                  const SizedBox(height: 16.0),
                  UserTextField(
                    controller: nameController,
                    titleText: "Nama User*",
                    hintText: "Masukkan Nama User",
                    validationErrorMessage: "Nama User Belum diisi",
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 16.0),
                  UserTextField(
                    controller: addressController,
                    titleText: "Alamat*",
                    hintText: "Masukkan Alamat",
                    validationErrorMessage: "Alamat Belum diisi",
                    textInputType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 16.0),
                  UserTextField(
                    controller: emailController,
                    titleText: "Email*",
                    hintText: "Masukkan Email",
                    validationErrorMessage: "Email Belum diisi",
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  UserTextField(
                    controller: phoneNumberController,
                    titleText: "Nomor Handphone*",
                    hintText: "Masukkan Nomor Handphone",
                    validationErrorMessage: "Nomor Handphone Belum diisi",
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16.0),
                  UserTextField(
                    controller: cityController,
                    titleText: "Kota*",
                    hintText: "Masukkan Kota",
                    validationErrorMessage: "Kota Belum diisi",
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        UserModel user = UserModel(
                          name: nameController.text,
                          address: addressController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          city: cityController.text,
                        );

                        context
                            .read<AddUserBloc>()
                            .add(EventAddUser(user: user));
                      }
                      nameController.clear();
                      addressController.clear();
                      emailController.clear();
                      phoneNumberController.clear();
                      cityController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RoundedContainer(
                        radius: 360.0,
                        containerColor: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 111.5),
                          child: Center(
                            child: Text('Tambah User',
                                style: CustomTextStyle.textLargeMedium
                                    .copyWith(color: AppColors.whiteColor)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
