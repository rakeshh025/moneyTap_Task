import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:wiki_search_app/src/blocs/search_event.dart';
import 'package:wiki_search_app/src/blocs/search_state.dart';
import 'package:wiki_search_app/src/models/search_results.dart';
import 'dart:convert';

class SearchBloc extends Bloc<SearchEvent, SearchState> {


  @override
  // TODO: implement initialState
  SearchState get initialState => SearchResultsPageInitial();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    // TODO: implement mapEventToState
    final currentState = state;

    if (event is UserReachesSearchPageEvent) {
      yield ShowLoading();
      final items = await _fetchItems(event.searchString);
      if(items != null && items.isNotEmpty) {
        yield ShowSearchResults(items: items);
      } else {
        yield GetSearchResultsFailed(errorMessage: 'An error occurred. Please try again');
      }
    }
  }

  Future<List<Page>> _fetchItems(String searchString) async {
    try {
      Client client = Client();
      String url = 'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=$searchString&gpslimit=30';

      final response = await client.get(url);
      if (response.statusCode == 200) {
        SearchResults searchResults = SearchResults.fromJson(json.decode(response.body));
        final data = searchResults.query.pages;
        return data;
      } else {
        throw Exception('error searching');
      }
    } catch(e) {
      print('Exception occurred $e');
    }

  }
}