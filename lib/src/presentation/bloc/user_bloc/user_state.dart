part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserListEmpty extends UserState {}

class UserListLoading extends UserState {}

class UserListLoaded extends UserState {
  final List<UserEntity> users;

  const UserListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserDeletedSuccess extends UserState {
  final List<UserEntity> users;

  const UserDeletedSuccess(this.users);

  @override
  List<Object> get props => [users];
}

class UserDeletedFailed extends UserState {
  const UserDeletedFailed(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class UserListFilteredLoaded extends UserState {
  final List<UserEntity> users;

  const UserListFilteredLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListSortedLoaded extends UserState {
  final List<UserEntity> users;

  const UserListSortedLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListError extends UserState {
  final String message;

  const UserListError(this.message);

  @override
  List<Object> get props => [message];
}
