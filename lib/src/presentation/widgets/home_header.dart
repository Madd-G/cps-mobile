import 'package:cps_mobile/core/routes/names.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/city_bloc/city_list_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    getCities();
  }

  void getCities() {
    context.read<CityBloc>().add(GetCity());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CPS Mobile', style: CustomTextStyle.textLargeRegular),
          const SizedBox(height: 12.0),
          TextField(
            onTap: () => Get.toNamed(AppRoutes.SEARCH),
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Search...',
              labelStyle: const TextStyle(
                color: AppColors.primaryColor,
              ),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(24),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: 12.0),
          const FilterSection(),
          const SizedBox(height: 10.0),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserListLoading) {
                return const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: 10.0,
                    width: 10.0,
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else if (state is UserListLoaded) {
                return Text(
                  '${state.users.length} data ditampilkan',
                  style: CustomTextStyle.textSmallRegular,
                );
              }
              if (state is UserListFilteredLoaded) {
                return Row(
                  children: [
                    Text(
                      '${state.users.length} data ditampilkan',
                      style: CustomTextStyle.textSmallRegular,
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        context.read<UserBloc>().add(GetUsersEvent());
                        context.read<CityBloc>().add(GetCity());
                      },
                      child: const RoundedContainer(
                        radius: 4.0,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(3, 2, 8, 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.close,
                                size: 10.0,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Reset filter',
                                style: CustomTextStyle.textExtraSmallRegular,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
