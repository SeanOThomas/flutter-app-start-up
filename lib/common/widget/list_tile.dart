import 'package:drop_poet/common/styles.dart';
import 'package:flutter/material.dart';

class NNListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onPressed;

  const NNListTile({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(color: FONT_BLACK_DARKER),
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
