import 'package:cps_mobile/src/data/models/city_model.dart';
import 'package:cps_mobile/src/domain/entities/cities_entity.dart';
import 'package:equatable/equatable.dart';

class CityResponse extends Equatable {
  final List<CityModel>? cities;

  const CityResponse({this.cities});

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        cities: json["cities"] == null
            ? null
            : List<CityModel>.from(
                json["cities"].map((x) => CityModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };

  CitiesEntity toEntity() {
    return CitiesEntity(
      cities: cities?.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        cities,
      ];
}
