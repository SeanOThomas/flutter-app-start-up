import 'package:flutter/material.dart';

const double _PADDING = 10;

class ContainerPage extends StatelessWidget {
  final Widget child;

  const ContainerPage({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_PADDING),
      child: child,
    );
  }
}
