import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? id;

  const UserModel({
    this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.city,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "city": city,
        "id": id,
      };

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      address: address,
      email: email,
      phoneNumber: phoneNumber,
      city: city,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        name,
        address,
        email,
        phoneNumber,
        city,
        id,
      ];
}
