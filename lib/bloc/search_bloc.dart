import 'package:github_search/models/search_resut.dart';
import 'package:github_search/services/data/github_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  GithubService _service = GithubService();

  final _searchController = new BehaviorSubject<String>();
  Observable<String> get searchFlux => _searchController.stream;
  Sink<String> get searchEvent => _searchController.sink;

  Observable<SearchResult> apiResultFlux;

  SearchBloc() {
    apiResultFlux = searchFlux
        .distinct()
        .where((i) => i.length > 2)
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 500)))
        .asyncMap(_service.search)
        .switchMap((i) => Observable.just(i));
  }

  void dispose() {
    _searchController.close();
  }
}
