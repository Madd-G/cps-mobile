import 'package:cps_mobile/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.name,
    super.address,
    super.email,
    super.phoneNumber,
    super.city,
    super.id,
  });

  const UserModel.empty()
      : this(
            name: '',
            address: '',
            email: '',
            phoneNumber: '',
            city: '',
            id: '');

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

  Map<String, dynamic> toJsonAddUser() => {
        "name": name,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "city": city,
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
