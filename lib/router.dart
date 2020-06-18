import 'package:drop_poet/poem/add_poem.dart';
import 'package:flutter/material.dart';

const String mapRoute = '/';
const String addPoemRoute = '/addPoem';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case addPoemRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => AddPoemPage());
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
            )
        );
    }
  }
}
