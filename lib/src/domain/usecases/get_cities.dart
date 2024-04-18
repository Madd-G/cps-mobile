import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:cps_mobile/src/domain/repositories/city_repository.dart';
import 'package:dartz/dartz.dart';

class GetCities {
  final CityRepository repository;

  GetCities(this.repository);

  Future<Either<Failure, List<CityEntity>>> execute() => repository.getCities();
}
