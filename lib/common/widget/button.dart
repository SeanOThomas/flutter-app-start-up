import 'package:drop_poet/common/styles.dart';
import 'package:flutter/material.dart';

const double DP_BUTTON_HEIGHT = 44;
const double DP_BUTTON_FONT_SIZE = 18;

class DPButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const DPButton(this.text, this.onPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: DP_BUTTON_HEIGHT,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryIconTheme.color,
        onPressed: () {
          onPressed();
        },
        child: Text(text),
      ),
    );
  }
}

class DPButtonAlt extends StatelessWidget {
  final String text;
  final Function onPressed;

  const DPButtonAlt(this.text, this.onPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: DP_BUTTON_HEIGHT,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(
            color: FONT_BLACK_MIDDLE,
            width: 1,
            style: BorderStyle.solid
        ), borderRadius: BorderRadius.circular(2)),
        textColor: Theme.of(context).primaryIconTheme.color,
        onPressed: () {
          onPressed();
        },
        child: Text(text),
      ),
    );
  }
}
