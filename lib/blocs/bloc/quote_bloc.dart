import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_motivation_quotes/models/quote.dart';
import 'package:flutter_motivation_quotes/repositories/sample_quote_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc({SampleQuoteRepository quoteRepository})
      : _quoteRepository = quoteRepository,
        _quotePage = 1,
        super(QuoteState.initial());

  final SampleQuoteRepository _quoteRepository;

  final _quoteLimit = 3;
  int _quotePage;

  @override
  Stream<QuoteState> mapEventToState(
    QuoteEvent event,
  ) async* {
    if (event is FetchQuotes) {
      try {
        if (state.hasReachedMax) return;

        yield QuoteState.loadInProgress();

        if (state.status == QuoteStatus.initial) {
          // fetch new quotes
          final quotes = await _quoteRepository.getAllQuotes(
            page: _quotePage,
            limit: _quoteLimit,
          );

          // update state
          yield QuoteState.loadSuccess(
            quotes: quotes,
            hasReachedMax: _hasReachedMax(quotes.length),
          );
        } else {
          _quotePage++;
          // fetch new quotes
          final quotes = await _quoteRepository.getAllQuotes(
            page: _quotePage,
            limit: _quoteLimit,
          );

          // update state
          yield quotes.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : QuoteState.loadSuccess(
                  quotes: List.of(state.quotes)..addAll(quotes),
                  hasReachedMax: _hasReachedMax(quotes.length),
                );
        }
      } catch (_) {
        yield QuoteState.loadFailure();
      }
    }
  }

  bool _hasReachedMax(int quotesCount) =>
      quotesCount < _quoteLimit ? false : true;
}
