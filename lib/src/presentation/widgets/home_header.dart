import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/city_bloc/city_list_bloc.dart';
import 'package:cps_mobile/src/presentation/pages/search_page.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String sortByName = 'A-Z';

  static final List<Map<String, String>> sortList = [
    {
      "label": "A-Z",
      "value": "A-Z",
    },
    {
      "label": "Z-A",
      "value": "Z-A",
    },
  ];

  @override
  void initState() {
    super.initState();
    getCities();
  }

  void getCities() {
    context.read<CityBloc>().add(CityEvent());
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CityDropdown(),
              const SizedBox(width: 10.0),
              Expanded(
                child: RoundedContainer(
                  height: 45.0,
                  radius: 5.0,
                  containerColor: AppColors.redSecondaryColor,
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
                        items: sortList.map((val) {
                          return DropdownMenuItem<String>(
                            value: val['value'],
                            child: Text(val['value']!,
                                style: CustomTextStyle.textRegular),
                          );
                        }).toList(),
                        hint: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.abc,
                              color: AppColors.greyColor,
                              size: 15.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              sortByName,
                              style: CustomTextStyle.textRegular.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        onChanged: (String? val) {
                          setState(
                            () {
                              sortByName = val!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
