import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

class CitiesEntity extends Equatable {
  final List<CityEntity>? cities;

  const CitiesEntity({
    this.cities,
  });

  @override
  List<Object?> get props => [cities];

  @override
  String toString() {
    return 'Cities Entity { '
        '\n cities: $cities, '
        '\n}';
  }
}
