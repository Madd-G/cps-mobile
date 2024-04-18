import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SortUsers {
  final UserRepository repository;

  SortUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> execute(String sort) =>
      repository.getSortedUsers(sort: sort);
}
