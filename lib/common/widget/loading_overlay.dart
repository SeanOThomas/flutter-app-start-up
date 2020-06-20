import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

const Color TRANSPARENT_BLACK = Color(0x52000000);

class DPLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const DPLoadingOverlay({Key key, @required this.child, @required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: TRANSPARENT_BLACK,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      child: child,
      isLoading: isLoading,
    );
  }
}

class NNCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
    );
  }
}
