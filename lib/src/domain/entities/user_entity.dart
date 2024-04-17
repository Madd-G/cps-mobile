import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.city,
    this.id,
  });

  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? id;

  const UserEntity.bookmark({
    this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.city,
    this.id,
  });


  @override
  List<Object?> get props => [
        name,
        address,
        email,
        phoneNumber,
        city,
        id,
      ];

  @override
  String toString() {
    return 'User Entity { '
        '\n name: $name, '
        '\n address: $address, '
        '\n email: $email, '
        '\n phoneNumber: $phoneNumber, '
        '\n city: $city, '
        '\n id: $id, '
        '\n}';
  }
}
