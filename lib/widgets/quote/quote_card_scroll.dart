import 'package:flutter/material.dart';
import 'card_scroll.dart';

class QuoteCardScroll extends StatelessWidget {
  const QuoteCardScroll({
    Key key,
    @required this.currentPage,
    @required this.controller,
    this.quotes,
  }) : super(key: key);

  final double currentPage;
  final PageController controller;
  final quotes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardScrollWidget(currentPage: currentPage, quotes: quotes),
        Positioned.fill(
          child: PageView.builder(
            itemCount: quotes.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}
