import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:wiki_search_app/src/models/search_results.dart';


@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class ShowLoading extends SearchState {
  @override
  String toString() => 'ShowLoading';
}

class ShowSearchResults extends SearchState {
  final List<Page> items;

  const ShowSearchResults({@required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Search Results data: $items';

}

class GetSearchResultsFailed extends SearchState {
  final String errorMessage;
  GetSearchResultsFailed({@required this.errorMessage});

  @override
  String toString() => 'Get Search Results failed: $errorMessage';
}

class SearchResultsPageInitial extends SearchState {
  @override
  String toString() => 'Search Results page initial';
}

class NoResults extends SearchState {
  @override
  String toString() => 'No results';
}
