import 'package:drop_poet/common/styles.dart';
import 'package:flutter/material.dart';

class DPContainerPage extends StatelessWidget {
  final Widget child;
  final bool removeTopPadding;
  final double topPadding;

  const DPContainerPage({Key key, @required this.child, this.removeTopPadding = false, this.topPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getTopPadding(),
          left: PADDING_MEDIUM,
          right: PADDING_MEDIUM,
          bottom: PADDING_MEDIUM
      ),
      child: child,
    );
  }

  double getTopPadding() {
    if (removeTopPadding) return 0;
    if (topPadding != null) return topPadding;
    return PADDING_MEDIUM;
  }
}
