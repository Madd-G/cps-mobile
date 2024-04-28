import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/usecases/delete_user.dart';
import 'package:cps_mobile/src/domain/usecases/get_filtered_user.dart';
import 'package:cps_mobile/src/domain/usecases/get_users.dart';
import 'package:cps_mobile/src/domain/usecases/sort_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsers getUsers;
  final GetFilteredUser getFilteredUser;
  final SortUsers getSortedUser;
  final DeleteUser deleteUser;

  UserListBloc(
      this.getUsers, this.getFilteredUser, this.getSortedUser, this.deleteUser)
      : super(UserListEmpty()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UserListLoading());
      final result = await getUsers.execute();
      result.fold(
        (failure) => emit(UserListError(failure.message)),
        (usersData) {
          emit(UserListLoaded(usersData));
          if (usersData.isEmpty) {
            emit(UserListEmpty());
          }
        },
      );
    });
    on<GetFilteredUserListEvent>((event, emit) async {
      emit(UserListLoading());
      final result = await getFilteredUser.execute(event.city);
      result.fold(
        (failure) => emit(UserListError(failure.message)),
        (usersData) {
          emit(UserListFilteredLoaded(usersData));
          if (usersData.isEmpty) {
            emit(UserListEmpty());
          }
        },
      );
    });
    on<GetSortedUserListEvent>((event, emit) async {
      emit(UserListLoading());
      final result = await getSortedUser.execute(event.sort);
      result.fold(
        (failure) => emit(UserListError(failure.message)),
        (usersData) {
          emit(UserListSortedLoaded(usersData));
          if (usersData.isEmpty) {
            emit(UserListEmpty());
          }
        },
      );
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UserListLoading());
      final result = await deleteUser.execute(event.userId);
      result.fold(
        (failure) => emit(UserDeletedFailed(failure.message)),
        (usersData) {
          emit(UserDeletedSuccess(usersData));
          if (usersData.isEmpty) {
            emit(UserListEmpty());
          }
        },
      );
    });
  }
}
