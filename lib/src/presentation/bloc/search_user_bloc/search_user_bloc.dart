import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/usecases/search_user.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_user_event.dart';

part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUser _searchUsers;
  List<UserEntity> users = [];

  SearchUserBloc(this._searchUsers) : super(SearchUserInitial()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        if (query.isEmpty) {
          emit(SearchUserInitial());
        } else {
          emit(SearchUserLoading());
          final result = await _searchUsers.execute(query);
          result.fold(
            (failure) => emit(SearchUserError(failure.message)),
            (usersData) {
              users = usersData.users ?? [];
              emit(
                SearchUserHasData(
                  usersData.users ?? [],
                ),
              );
              if (usersData.users?.isEmpty == true) {
                emit(const SearchUserEmpty('No User Found'));
              }
            },
          );
        }
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<OnNextPage>(
      (event, emit) async {
        final query = event.query;
        if (query.isEmpty) {
          emit(SearchUserInitial());
        } else {
          final result = await _searchUsers.execute(query);
          result.fold((failure) => emit(SearchUserError(failure.message)),
              (userData) {
            users.addAll(userData.users ?? []);
            emit(
              SearchUserHasData(users),
            );
            if (userData.users?.isEmpty == true) {
              emit(const SearchUserEmpty('No User Found'));
            }
          });
        }
      },
      transformer: droppable(),
    );
  }
}

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
