import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
        ],
      ),
    );
  }
}
