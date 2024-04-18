import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/users_entity.dart';
import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  final List<UserModel>? cities;

  const UserResponse({this.cities});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        cities: json["users"] == null
            ? null
            : List<UserModel>.from(
                json["users"].map((x) => UserModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "users": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };

  UsersEntity toEntity() {
    return UsersEntity(
      users: cities?.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        cities,
      ];
}
