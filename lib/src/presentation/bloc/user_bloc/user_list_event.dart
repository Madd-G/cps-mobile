part of 'user_list_bloc.dart';

abstract class UserListEvent {}

class GetUsersEvent extends UserListEvent {}

class GetFilteredUserListEvent extends UserListEvent {
  String city;

  GetFilteredUserListEvent({required this.city});
}

class GetSortedUserListEvent extends UserListEvent {
  String sort;

  GetSortedUserListEvent({required this.sort});
}
