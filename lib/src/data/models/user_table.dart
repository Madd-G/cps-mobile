import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserTable extends Equatable {
  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? id;

  const UserTable({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.id,
  });

  factory UserTable.fromEntity(UserEntity user) => UserTable(
    name: user.name,
    address: user.address,
    email: user.email,
    phoneNumber: user.phoneNumber,
    city: user.city,
    id: user.id,
  );

  factory UserTable.fromMap(Map<String, dynamic> map) => UserTable(
    name: map['name'],
    address: map['address'],
    email: map['email'],
    phoneNumber: map['phoneNumber'],
    city: map['city'],
    id: map['id'],
  );

  factory UserTable.fromDTO(UserModel user) => UserTable(
    name: user.name,
    address: user.address,
    email: user.email,
    phoneNumber: user.phoneNumber,
    city: user.city,
    id: user.id,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'email': email,
    'phoneNumber': phoneNumber,
    'city': city,
    'id': id,
  };

  UserEntity toEntity() => UserEntity.bookmark(
    name: name,
    address: address,
    email: email,
    phoneNumber: phoneNumber,
    city: city,
    id: id,
  );

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

