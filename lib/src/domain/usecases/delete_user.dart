import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, List<UserEntity>>> execute(String userId) =>
      repository.deleteUser(userId);
}
