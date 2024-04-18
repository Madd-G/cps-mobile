part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListEmpty extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserEntity> users;

  const UserListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListFilteredLoaded extends UserListState {
  final List<UserEntity> users;

  const UserListFilteredLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListSortedLoaded extends UserListState {
  final List<UserEntity> users;

  const UserListSortedLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListError extends UserListState {
  final String message;

  const UserListError(this.message);

  @override
  List<Object> get props => [message];
}
