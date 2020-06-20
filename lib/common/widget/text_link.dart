import 'package:flutter/material.dart';

const double DP_TEXT_LINK_PADDING = 8;
const double DP_TEXT_LINK_FONT_SIZE = 15;

class DPTextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool topPadding;

  const DPTextLink({Key key, @required this.text, @required this.onPressed, this.topPadding = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: topPadding ? DP_TEXT_LINK_PADDING : 2,
                right: DP_TEXT_LINK_PADDING,
                left: DP_TEXT_LINK_PADDING,
                bottom: DP_TEXT_LINK_PADDING
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: DP_TEXT_LINK_FONT_SIZE,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
