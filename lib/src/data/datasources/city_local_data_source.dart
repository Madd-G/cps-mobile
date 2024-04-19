import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/models/city_table.dart';

import 'db/database_helper.dart';

abstract class CityLocalDataSource {
  Future<void> cacheCities(List<CityTable> cities);

  Future<List<CityTable>> getCachedCities();

}

class CityLocalDataSourceImpl implements CityLocalDataSource {
  final DatabaseHelper databaseHelper;

  CityLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheCities(List<CityTable> cities) async {
    await databaseHelper.clearCacheCities();
    await databaseHelper.insertCacheTransactionCities(cities, 'cities');
  }

  @override
  Future<List<CityTable>> getCachedCities() async {
    final result = await databaseHelper.getCacheCities('cities');
    if (result.isNotEmpty) {
      return result.map((data) => CityTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the city data");
    }
  }
}
