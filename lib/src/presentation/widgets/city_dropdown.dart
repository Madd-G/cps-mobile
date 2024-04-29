import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/city_bloc/city_list_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityDropdown extends StatefulWidget {
  const CityDropdown({super.key});

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  String selectedCity = 'Filter by city';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          debugPrint('...search state: $state');
          if (state is CityLoaded) {
            return RoundedContainer(
              height: 45.0,
              radius: 5.0,
              containerColor: AppColors.greenSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: EdgeInsets.zero,
                    isDense: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.greyColor,
                      size: 15.0,
                    ),
                    items: state.cities.map((val) {
                      return DropdownMenuItem<String>(
                        value: val.name,
                        child:
                            Text(val.name!, style: CustomTextStyle.textRegular),
                      );
                    }).toList(),
                    hint: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_city,
                          color: AppColors.greyColor,
                          size: 15.0,
                        ),
                        const SizedBox(width: 5.0),
                        BlocBuilder<CityBloc, CityState>(
                          builder: (context, state) {
                            if (state is CityFiltered) {
                              return Text(
                                selectedCity,
                                style: CustomTextStyle.textRegular.copyWith(
                                  color: AppColors.greyColor,
                                ),
                              );
                            }
                            return Text(
                              selectedCity,
                              style: CustomTextStyle.textRegular.copyWith(
                                color: AppColors.greyColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onChanged: (String? val) {
                      setState(
                        () {
                          selectedCity = val!;
                        },
                      );
                      context
                          .read<UserBloc>()
                          .add(GetFilteredUsersEvent(city: selectedCity));
                    },
                  ),
                ),
              ),
            );
          } else {
            return RoundedContainer(
              height: 45.0,
              radius: 5.0,
              containerColor: AppColors.greenSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: EdgeInsets.zero,
                    isDense: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.greyColor,
                      size: 15.0,
                    ),
                    items: const [],
                    hint: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_city,
                          color: AppColors.greyColor,
                          size: 15.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          "Filter by city",
                          style: CustomTextStyle.textRegular.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                    onChanged: (String? val) {
                      setState(
                        () {
                          selectedCity = val!;
                        },
                      );
                      context.read<UserBloc>().add(
                            GetFilteredUsersEvent(city: selectedCity),
                          );
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
