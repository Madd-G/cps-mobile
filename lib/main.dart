import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/route_util.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserListBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        home: const HomePage(),
      ),
    );
  }
}
