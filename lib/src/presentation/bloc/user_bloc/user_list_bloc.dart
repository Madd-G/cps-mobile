import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsers getUsers;

  UserListBloc(this.getUsers) : super(UserListEmpty()) {
    on<UserListEvent>((event, emit) async {
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
  }
}
