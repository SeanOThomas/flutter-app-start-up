import 'package:drop_poet/common/styles.dart';
import 'package:flutter/material.dart';

const double DP_DESCRIPTION_FONT_SIZE_LARGE = 32;
const double DP_DESCRIPTION_FONT_SIZE = 24;
const double DP_DESCRIPTION_FONT_SIZE_SMALL = 20;
const Color DP_DESCRIPTION_COLOR = FONT_BLACK;

class DPDescriptionTextBold extends StatelessWidget {
  final String text;
  final bool centerAlign;

  const DPDescriptionTextBold(this.text, {Key key, this.centerAlign = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: centerAlign ? TextAlign.center : TextAlign.start,
      style:
      TextStyle(fontSize: DP_DESCRIPTION_FONT_SIZE_LARGE, color: DP_DESCRIPTION_COLOR, fontWeight: FontWeight.bold),
    );
  }
}

class DPDescriptionText extends StatelessWidget {
  final String text;
  final bool centerAlign;

  const DPDescriptionText(this.text, {Key key, this.centerAlign = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: centerAlign ? TextAlign.center : TextAlign.start,
      style: TextStyle(fontSize: DP_DESCRIPTION_FONT_SIZE, color: DP_DESCRIPTION_COLOR),
    );
  }
}

class DPDescriptionTextSmall extends StatelessWidget {
  final String text;
  final bool centerAlign;

  const DPDescriptionTextSmall({Key key, this.text, this.centerAlign = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: centerAlign ? TextAlign.center : TextAlign.start,
      style: TextStyle(fontSize: DP_DESCRIPTION_FONT_SIZE_SMALL, color: DP_DESCRIPTION_COLOR),
    );
  }
}
