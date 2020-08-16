import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasource/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any)).thenAnswer(
      (_) async => <ResultSearchModel>[],
    );

    final result = await repository.search('wigny');

    expect(result | null, isA<List<ResultSearch>>());
  });

  test(
    'deve retornar uma DatasourceException se o datasource falhar',
    () async {
      when(datasource.getSearch(any)).thenThrow(
        Exception(),
      );

      final result = await repository.search('wigny');

      expect(result.fold(id, id), isA<DatasourceError>());
    },
  );
}
