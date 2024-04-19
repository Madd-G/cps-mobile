import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntity>>> getCities();
}
