import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF1b1e44).withAlpha(100),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              EvaIcons.starOutline,
              color: Color(0xFFFFB944),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              'Try for free',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ));
  }
}
