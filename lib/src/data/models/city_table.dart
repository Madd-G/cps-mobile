import 'package:cps_mobile/src/data/models/city_model.dart';
import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

class CityTable extends Equatable {
  final String? name;
  final String? id;

  const CityTable({
    required this.name,
    required this.id,
  });

  factory CityTable.fromEntity(CityEntity city) => CityTable(
        name: city.name,
        id: city.id,
      );

  factory CityTable.fromMap(Map<String, dynamic> map) => CityTable(
        name: map['name'],
        id: map['id'],
      );

  factory CityTable.fromDTO(CityModel city) => CityTable(
        name: city.name,
        id: city.id,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };

  CityEntity toEntity() => CityEntity(
    name: name,
    id: id,
  );

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
