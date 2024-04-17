part of 'search_user_bloc.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

class SearchUserInitial extends SearchUserState {}

class SearchUserEmpty extends SearchUserState {
  final String message;

  const SearchUserEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class SearchUserLoading extends SearchUserState {}

class SearchUserHasData extends SearchUserState {
  final List<UserEntity> searchResult;

  const SearchUserHasData(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

class SearchUserError extends SearchUserState {
  final String message;

  const SearchUserError(this.message);

  @override
  List<Object> get props => [message];
}
