import 'package:drop_poet/common/model/user_model.dart';
import 'package:drop_poet/common/services/auth_service.dart';
import 'package:drop_poet/common/services/firestore_service.dart';
import 'package:drop_poet/router.dart';
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
        home: MyHomePage(title: 'Drop Poet'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Navigator.pushNamed(context, addPoemRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
