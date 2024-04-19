import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:cps_mobile/src/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 12.0, right: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              TextField(
                onChanged: (query) {
                  query = query;
                  context
                      .read<SearchUserBloc>()
                      .add(OnQueryChanged(query.toLowerCase()));
                },
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
              const SizedBox(height: 20.0),
              const SizedBox(height: 10.0),
              BlocBuilder<SearchUserBloc, SearchUserState>(
                builder: (context, state) {
                  if (state is SearchUserInitial) {
                    return const SizedBox.shrink();
                  } else if (state is SearchUserLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  } else if (state is SearchUserHasData) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${state.searchResult.length} data ditampilkan',
                        style: CustomTextStyle.textSmallRegular,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Flexible(
                child: BlocBuilder<SearchUserBloc, SearchUserState>(
                  builder: (context, state) {
                    if (state is SearchUserInitial) {
                      return const Center(child: Initial());
                    } else if (state is SearchUserLoading) {
                      return const LoadingUserList();
                    } else if (state is SearchUserHasData) {
                      final result = state.searchResult;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemBuilder: (context, index) {
                          final user = result[index];
                          return UserList(user: user);
                        },
                        itemCount: result.length,
                      );
                    } else if (state is SearchUserEmpty) {
                      return const Center(child: NoData());
                    } else if (state is SearchUserError) {
                      return Center(child: Error(message: state.message));
                    } else {
                      return Center(child: Text(state.runtimeType.toString()));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
