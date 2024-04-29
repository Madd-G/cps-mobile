part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  const UpdateUserSuccess(this.users);

  final List<UserEntity> users;

  @override
  List<Object> get props => [users];
}

class UpdateUserError extends UpdateUserState {
  final String message;

  const UpdateUserError(this.message);

  @override
  List<Object> get props => [message];
}
