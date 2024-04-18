import 'dart:io';

import 'package:cps_mobile/core/common/common.dart';
import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/datasources/user_local_data_source.dart';
import 'package:cps_mobile/src/data/datasources/user_remote_datasources.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/data/models/user_response.dart';
import 'package:cps_mobile/src/data/models/user_table.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/entities/users_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        UserResponse result = await remoteDataSource.getUsers();
        localDataSource.cacheUsers(
          result.cities?.map((user) => UserTable.fromDTO(user)).toList() ?? [],
        );
        return Right(
            result.cities?.map((model) => model.toEntity()).toList() ?? []);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedUsers();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFilteredUsers({required String city}) async {
    if (await networkInfo.isConnected) {
      try {
        UserResponse result = await remoteDataSource.getFilteredUsers(city: city);
        localDataSource.cacheUsers(
          result.cities?.map((user) => UserTable.fromDTO(user)).toList() ?? [],
        );
        return Right(
            result.cities?.map((model) => model.toEntity()).toList() ?? []);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedUsers();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, UsersEntity>> searchUsers(String query) async {
    if (await networkInfo.isConnected) {
      try {
        UserResponse result = await remoteDataSource.searchUsers(query);
        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        var result = await localDataSource.searchLocalUsers(query);
        var users = UsersEntity(
          users: result.map((userTable) => userTable.toEntity()).toList(),
        );
        return Right(users);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  ResultFuture<List<UserModel>> addUser({
    required UserModel employee,
  }) async {
    try {
      await remoteDataSource.addUser(user: employee);
      final UserResponse employees = await remoteDataSource.getUsers();
      return Right(employees.cities!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}
