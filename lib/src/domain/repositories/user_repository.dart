import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
}