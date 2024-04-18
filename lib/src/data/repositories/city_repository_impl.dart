import 'package:cps_mobile/core/common/common.dart';
import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/datasources/city_local_data_source.dart';
import 'package:cps_mobile/src/data/datasources/city_remote_datasources.dart';
import 'package:cps_mobile/src/data/models/city_response.dart';
import 'package:cps_mobile/src/data/models/city_table.dart';
import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:cps_mobile/src/domain/repositories/city_repository.dart';
import 'package:dartz/dartz.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource remoteDataSource;
  final CityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    if (await networkInfo.isConnected) {
      try {
        CityResponse result = await remoteDataSource.getCities();
        localDataSource.cacheCities(
          result.cities?.map((city) => CityTable.fromDTO(city)).toList() ?? [],
        );
        return Right(
            result.cities?.map((model) => model.toEntity()).toList() ?? []);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedCities();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
