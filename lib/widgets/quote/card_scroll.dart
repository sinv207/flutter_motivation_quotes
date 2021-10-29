import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_motivation_quotes/config/data.dart';
import 'package:flutter_motivation_quotes/models/quote.dart';

import '../button_view/rounded_icon_button.dart';
import 'quote_card_item.dart';

var cardAspectRatio = 9.0 / 16.0; // 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;
  final List<Quote> quotes;

  CardScrollWidget({
    Key key,
    this.currentPage,
    this.quotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2.5; // primaryCardLeft / 2;

        List<Widget> cardList = [];
        if (quotes.isEmpty) {
          return Container();
        }

        for (var i = 0; i < quotes.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset *
                          -delta *
                          (isOnRight ? 16.25 : 1), // (isOnRight ? 15 : 1)
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: QuoteCardItem(
                bgImage: images[i % images.length], quote: quotes[i]),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
