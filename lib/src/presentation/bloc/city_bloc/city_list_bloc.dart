import 'package:cps_mobile/src/domain/entities/city_entity.dart';
import 'package:cps_mobile/src/domain/usecases/get_cities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'city_list_event.dart';

part 'city_list_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCities getCities;

  CityBloc(this.getCities) : super(CityEmpty()) {
    on<GetCity>((event, emit) async {
      emit(CityLoading());
      final result = await getCities.execute();
      result.fold(
        (failure) => emit(CityError(failure.message)),
        (cities) {
          emit(CityLoaded(cities));
          if (cities.isEmpty) {
            emit(CityEmpty());
          }
        },
      );
    });
  }
}
