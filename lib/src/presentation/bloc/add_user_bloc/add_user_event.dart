part of 'add_user_bloc.dart';

@immutable
abstract class AddUserEvent {}

class EventAddUser extends AddUserEvent {
  EventAddUser({required this.user});

  final UserModel user;

  List<String> get props => [];
}
