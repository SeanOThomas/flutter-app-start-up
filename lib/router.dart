import 'package:drop_poet/common/destination.dart';
import 'package:drop_poet/login/login_page.dart';
import 'package:drop_poet/poem/add_poem.dart';
import 'package:flutter/material.dart';

const String mapRoute = '/';
const String addPoemRoute = '/addPoem';
const String loginRoute = '/login';
const String forgotPasswordRoute = '/forgotPassword';
const String registerRoute = '/registerRoute';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case addPoemRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => AddPoemPage());
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginPage(destination: settings.arguments as Destination));
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
