import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/usecases/add_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_user_event.dart';

part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AddUser _addUser;

  AddUserBloc(this._addUser) : super(AddUserInitial()) {
    on<EventAddUser>((event, emit) async {
      final result = await _addUser(
        AddUserParams(user: event.user),
      );
      result.fold(
        (failure) {
          emit(AddUserError(failure.message));
        },
        (users) {
          emit(AddUserSuccess([event.user]));
        },
      );
    });
  }
}
