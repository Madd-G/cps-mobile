import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UsersEntity extends Equatable {
  final List<UserEntity>? users;

  const UsersEntity({this.users});

  @override
  List<Object?> get props => [users];

  @override
  String toString() {
    return 'Users Entity { '
        '\n users: $users, '
        '\n}';
  }
}
