part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUsersEvent extends UserEvent {}

class GetFilteredUsersEvent extends UserEvent {
  String city;

  GetFilteredUsersEvent({required this.city});
}

class GetSortedUsersEvent extends UserEvent {
  String sort;

  GetSortedUsersEvent({required this.sort});
}

class DeleteUserEvent extends UserEvent {
  String userId;

  DeleteUserEvent({required this.userId});
}
