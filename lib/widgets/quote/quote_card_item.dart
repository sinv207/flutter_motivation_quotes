import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motivation_quotes/models/models.dart';

import '../button_view/button_view.dart';

var cardAspectRatio = 9.0 / 16.0; // 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class QuoteCardItem extends StatelessWidget {
  const QuoteCardItem({
    Key key,
    @required this.quote,
    this.bgImage,
  }) : super(key: key);

  final Quote quote;
  final String bgImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
        ]),
        child: AspectRatio(
          aspectRatio: cardAspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken,
                ),
                child: Image.asset(bgImage, fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        quote.quote,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'SF-Pro-Text-Regular'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        '- ${quote.author} -',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'SF-Pro-Text-Regular'),
                      ),
                    ),
                    // CircleButton()
                    Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedIconButton(
                            // icon: EvaIcons.undo,
                            icon: CupertinoIcons.share,
                            color: Colors.transparent,
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          RoundedIconButton(
                            icon: CupertinoIcons.heart,
                            color: Colors.transparent,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Icon(
                    // Icons.fullscreen,
                    EvaIcons.expand,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
