import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:flutter_motivation_quotes/models/quote.dart';
import 'package:flutter_motivation_quotes/services/api.dart';

class SampleQuoteRepository {
  final ApiService _quoteApiClient;

  SampleQuoteRepository({ApiService quoteApiClient})
      : _quoteApiClient = quoteApiClient ?? ApiService();

  Future<List<Quote>> getAllQuotes({int page, int limit}) async {
    print('getAllQuotes');
    final response = await _quoteApiClient.dio
        .get('/quotes', queryParameters: {'page': page, 'limit': limit});
    return (response.data['data'] as List)
        .map((json) => Quote.fromJson(json))
        .toList();
  }
}
