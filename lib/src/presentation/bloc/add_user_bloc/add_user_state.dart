part of 'add_user_bloc.dart';

@immutable
abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

// class AddUserSuccess extends AddUserState {}

class AddUserSuccess extends AddUserState {
  const AddUserSuccess(this.users);

  final List<UserEntity> users;

  @override
  List<Object> get props => [users];
}

class AddUserError extends AddUserState {
  final String message;

  const AddUserError(this.message);

  @override
  List<Object> get props => [message];
}
