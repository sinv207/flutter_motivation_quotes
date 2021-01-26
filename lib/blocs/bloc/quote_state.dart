part of 'quote_bloc.dart';

enum QuoteStatus { initial, loading, success, failure }

extension QuoteStatusX on QuoteStatus {
  bool get isInitial => this == QuoteStatus.initial;
  bool get isLoading => this == QuoteStatus.loading;
  bool get isSuccess => this == QuoteStatus.success;
  bool get isFailure => this == QuoteStatus.failure;
}

@JsonSerializable()
class QuoteState extends Equatable {
  const QuoteState._({
    this.status = QuoteStatus.initial,
    this.quotes = const <Quote>[],
    this.hasReachedMax = false,
  });

  final QuoteStatus status;
  final List<Quote> quotes;
  final bool hasReachedMax;

  QuoteState.initial() : this._();

  QuoteState.loadInProgress() : this._(status: QuoteStatus.loading);

  QuoteState.loadSuccess({
    List<Quote> quotes,
    bool hasReachedMax,
  }) : this._(
          quotes: quotes,
          status: QuoteStatus.success,
          hasReachedMax: hasReachedMax,
        );

  QuoteState.loadFailure() : this._(status: QuoteStatus.failure);

  QuoteState copyWith({
    QuoteStatus status,
    Quote quote,
    bool hasReachedMax,
  }) {
    return QuoteState._(
      status: status ?? this.status,
      quotes: quotes ?? this.quotes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, quotes, hasReachedMax];
}
