import 'dart:convert';

import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  Quote({
    this.quote,
    this.author,
  });

  final String quote;
  final String author;

  Quote copyWith({
    String quote,
    String author,
  }) {
    return Quote(
      quote: quote ?? this.quote,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
    };
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Quote(
      quote: json['quoteText'],
      author: json['quoteAuthor'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Quote(quote: $quote, author: $author)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Quote && o.quote == quote && o.author == author;
  }

  @override
  int get hashCode => quote.hashCode ^ author.hashCode;

  @override
  List<Object> get props => [quote, author];
}
