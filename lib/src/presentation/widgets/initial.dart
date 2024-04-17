import 'package:cps_mobile/core/res/app_media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AppMedia.searchAnimation,
          width: 250,
          height: 250,
          fit: BoxFit.fill,
          repeat: true,
          animate: true,
        ),
        const SizedBox(height: 8),
        const Text(
          'Search user',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
