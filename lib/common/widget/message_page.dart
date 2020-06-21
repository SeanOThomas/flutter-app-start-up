import 'package:drop_poet/common/styles.dart';
import 'package:drop_poet/common/widget/button.dart';
import 'package:drop_poet/common/widget/container_page.dart';
import 'package:drop_poet/common/widget/description_text.dart';
import 'package:flutter/material.dart';

class DPMessagePage extends StatelessWidget {
  final String header;
  final String message;
  final String actionText;
  final Function onAction;

  const DPMessagePage(this.message, {Key key, this.header, this.actionText, this.onAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DPContainerPage(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (header != null)
                Padding(
                    padding: EdgeInsets.only(bottom: PADDING_SMALL_EXTRA),
                    child: DPDescriptionTextBold(
                      header,
                      centerAlign: true,
                    )),
              DPDescriptionText(
                message,
                centerAlign: true,
              ),
              if (actionText != null && onAction != null)
                Padding(
                  padding: EdgeInsets.only(top: PADDING_LARGE_EXTRA),
                  child: DPButton(actionText, onAction),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
