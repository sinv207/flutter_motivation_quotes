import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../button_view/rounded_icon_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RoundedIconButton(
            text: 'Categories',
            icon: EvaIcons.gridOutline,
            // icon: EvaIcons.layoutOutline,
          ),
          Spacer(),
          RoundedIconButton(
            icon: EvaIcons.colorPaletteOutline,
          ),
          SizedBox(
            width: 20,
          ),
          RoundedIconButton(
            icon: EvaIcons.menu2Outline,
          ),
        ],
      ),
    );
  }
}
