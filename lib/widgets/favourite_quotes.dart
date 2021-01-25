import 'package:flutter/material.dart';

import '../customIcons.dart';

class FavouriteQuotes extends StatelessWidget {
  const FavouriteQuotes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Favourite',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46.0,
                    fontFamily: 'Calibre-Semibold',
                    letterSpacing: 1.0,
                  )),
              IconButton(
                icon: Icon(
                  CustomIcons.option,
                  size: 12.0,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                    child:
                        Text('Latest', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text('9+ Stories', style: TextStyle(color: Colors.white))
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/images/image_02.jpg',
                    width: 296.0, height: 222.0),
              ),
            )
          ],
        )
      ],
    );
  }
}
