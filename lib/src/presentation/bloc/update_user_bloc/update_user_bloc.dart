import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_user_event.dart';

part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUser _updateUser;

  UpdateUserBloc(this._updateUser) : super(UpdateUserInitial()) {
    on<EventUpdateUser>((event, emit) async {
      final result = await _updateUser(
        UpdateUserParams(userId: event.userId, user: event.user),
      );
      result.fold(
        (failure) {
          emit(UpdateUserError(failure.message));
        },
        (users) {
          emit(UpdateUserSuccess([event.user]));
        },
      );
    });
  }
}
