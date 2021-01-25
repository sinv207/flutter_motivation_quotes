import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:flutter_motivation_quotes/models/quote.dart';

class SampleQuoteRepository {
  final SampleQuoteApi _quoteApiClient;

  SampleQuoteRepository({SampleQuoteApi quoteApiClient})
      : _quoteApiClient = quoteApiClient ?? SampleQuoteApi();
// '  https://quote-garden.herokuapp.com/api/v3/quotes'

  Future<List<Quote>> getAllQuotes({int page, int limit}) async {
    print('getAllQuotes');
    final response = await _quoteApiClient.getAllQuotes(page: 1, limit: 20);
    return (response.data['data'] as List)
        .map((json) => Quote.fromJson(json))
        .toList();
  }
}

class SampleQuoteApi {
  Future<Response> getAllQuotes({int page, int limit}) async {
    return Dio().get('https://quote-garden.herokuapp.com/api/v3/quotes',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(contentType: 'application/json'));
  }
}
