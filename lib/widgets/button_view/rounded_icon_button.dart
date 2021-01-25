import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
    this.color,
    this.textColor,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            color ?? Color(0xFF2d3447).withAlpha(100), // 0xFF2d3447  0xFF1b1e44
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: text != null
          ? Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ],
            )
          : Icon(
              icon,
              color: textColor ?? Colors.white,
            ),
    );
  }
}
