import 'package:flutter/material.dart';

class NoLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
              "We need your location to show you posts around you. "
                  "\nYou can restart the app or go to device settings to grant the permission.")),
    );
  }
}
