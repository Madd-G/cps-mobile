import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/models/user_table.dart';

import 'db/database_helper.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUsers(List<UserTable> users);

  Future<List<UserTable>> getCachedUsers();

  Future<List<UserTable>> searchLocalUsers(String query);

  Future<List<UserTable>> filterLocalUsers(String query);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseHelper databaseHelper;

  UserLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheUsers(List<UserTable> users) async {
    await databaseHelper.clearCacheUsers('users');
    await databaseHelper.insertCacheTransactionUsers(users, 'users');
  }

  @override
  Future<List<UserTable>> getCachedUsers() async {
    final result = await databaseHelper.getCacheUsers("");
    if (result.isNotEmpty) {
      return result.map((data) => UserTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data");
    }
  }

  @override
  Future<List<UserTable>> searchLocalUsers(String query) async {
    final result = await databaseHelper.getCacheUsers(query);

    if (result.isNotEmpty) {
      final filteredResults = result
          .map((data) => UserTable.fromMap(data))
          .where((user) => user.name!.toLowerCase().contains(query))
          .toList();

      if (filteredResults.isNotEmpty) {
        return filteredResults;
      } else {
        throw CacheException("No users found");
      }
    } else {
      throw CacheException("Can't get the data");
    }
  }

  @override
  Future<List<UserTable>> filterLocalUsers(String query) async {
    final result = await databaseHelper.getCacheFilteredUsers(query);

    if (result.isNotEmpty) {
      return result.map((data) => UserTable.fromMap(data)).toList();
    } else if (result.isEmpty) {
      throw CacheException("No user found");
    } {
      throw CacheException("Can't get the data");
    }
  }
}
