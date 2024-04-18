part of 'city_list_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityEmpty extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityEntity> cities;

  const CityLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}

class CityError extends CityState {
  final String message;

  const CityError(this.message);

  @override
  List<Object> get props => [message];
}
