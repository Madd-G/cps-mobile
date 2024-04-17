import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
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
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            stretch: true,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.0), child: HomeHeader()),
          ),
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                getNews();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 12.0, right: 24.0),
                child: ListView(
                  children: [
                    BlocBuilder<UserListBloc, UserListState>(
                      builder: (context, state) {
                        if (state is UserListLoading) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 8),
                            child: const LoadingUserList(),
                          );
                        } else if (state is UserListLoaded) {
                          return Container(
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
          )
        ],
      ),
    ));
  }
}
