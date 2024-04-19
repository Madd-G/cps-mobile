import 'package:cps_mobile/src/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({
    super.name,
    super.id,
  });

  const CityModel.empty() : this(name: '', id: '');

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };

  CityEntity toEntity() {
    return CityEntity(
      name: name,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
