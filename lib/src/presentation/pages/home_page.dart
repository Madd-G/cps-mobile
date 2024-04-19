import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    context.read<UserListBloc>().add(GetUsersEvent());
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
                  preferredSize: Size.fromHeight(130.0), child: HomeHeader()),
            ),
            SliverFillRemaining(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  getUsers();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, top: 12.0, right: 24.0),
                  child: BlocListener<AddUserBloc, AddUserState>(
                    listener: (context, state) {
                      if (state is AddUserSuccess) {
                        context.read<UserListBloc>().add(GetUsersEvent());
                      }
                    },
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
                            } else if (state is UserListFilteredLoaded) {
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
                            } else if (state is UserListSortedLoaded) {
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
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: const AddUserButton(),
    );
  }
}
