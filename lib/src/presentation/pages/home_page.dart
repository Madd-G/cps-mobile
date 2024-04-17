import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/loading_user_list.dart';
import 'package:cps_mobile/src/presentation/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() {
    context.read<UserListBloc>().add(UserListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak App'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const SearchPage(),
                //   ),
                // );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          getNews();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 12.0, right: 24.0),
          child: ListView(
            children: [
              const Text('Category'),
              const SizedBox(height: 8),
              BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
                  if (state is UserListLoading) {
                    return Container(
                      color: AppColors.whiteColor,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 8),
                      child: const LoadingUserList(),
                    );
                  } else if (state is UserListLoaded) {
                    return Container(
                      color: AppColors.whiteColor,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          var user = state.users[index];
                          return UserList(user: user);
                        },
                      ),
                    );
                  } else if (state is UserListEmpty) {
                    return const Center(child: Text('User is empty'));
                  } else if (state is UserListError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text(''));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
