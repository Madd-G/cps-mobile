part of 'search_user_bloc.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchUserEvent {
  final String query;
 
  const OnQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}

class OnNextPage extends SearchUserEvent {
  final String query;
  final int page;

  const OnNextPage(
    this.query,
    this.page,
  );

  @override
  List<Object> get props => [query, page];
}
