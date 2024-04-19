// ignore_for_file: constant_identifier_names

import 'package:cps_mobile/src/presentation/pages/home_page.dart';
import 'package:cps_mobile/src/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.HOME;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchPage(),
    ),
  ];
}
