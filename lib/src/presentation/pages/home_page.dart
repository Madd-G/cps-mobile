import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/update_user_bloc/update_user_bloc.dart';
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
                  child: BlocListener<UpdateUserBloc, UpdateUserState>(
                    listener: (context, state) {
                      if (state is UpdateUserSuccess) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            message: 'Berhasil mengupdate user',
                            icon: Icon(
                              Icons.update,
                              color: AppColors.whiteColor,
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                        context.read<UserListBloc>().add(GetUsersEvent());
                      } else if (state is UpdateUserError) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            message:
                                'Oops... Anda harus terhubung dengan internet untuk mengupdate user',
                            icon: Icon(
                              Icons.error,
                              color: AppColors.whiteColor,
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: AppColors.redColor,
                          ),
                        );
                      }
                    },
                    child: BlocListener<AddUserBloc, AddUserState>(
                      listener: (context, state) {
                        if (state is AddUserSuccess) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message: 'Sukses menambahkan user',
                              icon: Icon(
                                Icons.save,
                                color: AppColors.whiteColor,
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          );
                          context.read<UserListBloc>().add(GetUsersEvent());
                        } else if (state is AddUserError) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message:
                                  'Oops... Anda harus terhubung dengan internet untuk menambah user',
                              icon: Icon(
                                Icons.error,
                                color: AppColors.whiteColor,
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: AppColors.redColor,
                            ),
                          );
                        }
                      },
                      child: ListView(
                        children: [
                          BlocConsumer<UserListBloc, UserListState>(
                            listener:
                                (BuildContext context, UserListState state) {
                              if (state is UserDeletedSuccess) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    message: 'Sukses menghapus user',
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.redSecondaryColor,
                                    ),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                );
                              } else if (state is UserDeletedFailed) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    message:
                                        'Oops... Anda harus terhubung dengan internet untuk menghapus user',
                                    icon: Icon(
                                      Icons.error,
                                      color: AppColors.whiteColor,
                                    ),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: AppColors.redColor,
                                  ),
                                );
                                context
                                    .read<UserListBloc>()
                                    .add(GetUsersEvent());
                              }
                            },
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.users.length,
                                    itemBuilder: (context, index) {
                                      var user = state.users[index];
                                      return UserList(user: user);
                                    },
                                  ),
                                );
                              } else if (state is UserDeletedSuccess) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(top: 8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.users.length,
                                    itemBuilder: (context, index) {
                                      var user = state.users[index];
                                      return UserList(user: user);
                                    },
                                  ),
                                );
                              } else if (state is UserListEmpty) {
                                return const Center(
                                    child: Text('User is empty'));
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
              ),
            )
          ],
        ),
      ),
      floatingActionButton: const AddUserButton(),
    );
  }
}
