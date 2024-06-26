import 'package:cps_mobile/core/res/app_media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AppMedia.noDataAnimation,
          width: 400,
          height: 300,
          fit: BoxFit.fill,
          repeat: false,
          animate: true,
        ),
        const Text('No data available'),
      ],
    );
  }
}
