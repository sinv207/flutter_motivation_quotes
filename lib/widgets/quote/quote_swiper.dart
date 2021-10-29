import 'package:flutter/material.dart';
import 'package:flutter_motivation_quotes/config/data.dart';
import 'package:flutter_motivation_quotes/models/models.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'quote_card_item.dart';

class QuoteSwiper extends StatefulWidget {
  QuoteSwiper({Key key, this.quotes}) : super(key: key);
  final List<Quote> quotes;

  @override
  _QuoteSwiperState createState() => _QuoteSwiperState();
}

class _QuoteSwiperState extends State<QuoteSwiper> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      padding: const EdgeInsets.all(20),
      child: Swiper(
        scrollDirection: Axis.vertical,
        itemCount: widget.quotes.length,
        itemWidth: 300,
        itemHeight: 420,
        layout: SwiperLayout.STACK,
        viewportFraction: 0.85,
        scale: 0.9,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              QuoteCardItem(
                bgImage: images[index % images.length],
                quote: widget.quotes[index],
              ),
              Positioned(
                child: Visibility(
                  visible: _currentIndex == index,
                  child: Text('$_currentIndex / ${widget.quotes.length}'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
