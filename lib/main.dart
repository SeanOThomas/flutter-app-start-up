import 'package:drop_poet/router.dart';
import 'package:drop_poet/search/search_page.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        ProxyProvider2<AuthService, FirestoreService, UserModel>(update: (context, auth, firestore, _) {
          return UserModel(auth, firestore);
        }),
      ],
      child: MaterialApp(
        title: 'Drop Poet',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SearchPage(),
      ),
    );
  }
}
