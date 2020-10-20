import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wiki_search_app/src/models/search_results.dart';

abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super();
}

class UserReachesSearchPageEvent extends SearchEvent {
  final String searchString;

  UserReachesSearchPageEvent(
      {this.searchString})
      : super([searchString]);

  @override
  List<Object> get props => ['UserReachesSearchPageEvent'];

  @override
  String toString() {
    return 'User Reaches Search Page';
  }
}
