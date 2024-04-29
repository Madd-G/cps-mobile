part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserEvent {}

class EventUpdateUser extends UpdateUserEvent {
  EventUpdateUser({required this.userId, required this.user});

  final String userId;
  final UserModel user;

  List<Object> get props => [userId, user];
}
