part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

class FetchQuotes extends QuoteEvent {
  FetchQuotes({
    this.page,
    this.limit,
    this.genre,
    this.author,
  });

  final int page, limit;
  final String genre, author;

  @override
  List<Object> get props => [page, limit, genre, author];
}
