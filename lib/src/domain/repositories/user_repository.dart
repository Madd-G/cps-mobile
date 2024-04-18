import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/entities/users_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();

  Future<Either<Failure, UsersEntity>> searchUsers(String query);

  ResultFuture<List<UserEntity>> addUser({
    required UserModel employee,
  });
}
