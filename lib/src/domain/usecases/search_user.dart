import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/users_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SearchUser {
  final UserRepository repository;

  SearchUser(this.repository);

  Future<Either<Failure, UsersEntity>> execute(String query) =>
      repository.searchUsers(query);
}
