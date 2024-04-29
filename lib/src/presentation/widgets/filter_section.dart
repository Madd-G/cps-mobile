import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  String sortByName = 'A-Z';

  static final List<Map<String, String>> sortList = [
    {
      "label": "A-Z",
      "value": "asc",
    },
    {
      "label": "Z-A",
      "value": "desc",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      child: Text(val['label']!,
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
                    context
                        .read<UserBloc>()
                        .add(GetSortedUsersEvent(sort: sortByName));
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
