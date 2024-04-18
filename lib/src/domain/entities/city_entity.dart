import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  const CityEntity({
    this.name,
    this.id,
  });

  final String? name;
  final String? id;

  @override
  List<Object?> get props => [
        name,
        id,
      ];

  @override
  String toString() {
    return 'City Entity { '
        '\n name: $name, '
        '\n id: $id, '
        '\n}';
  }
}
