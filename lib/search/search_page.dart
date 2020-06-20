import 'package:drop_poet/common/destination.dart';
import 'package:drop_poet/router.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userModel.isLoggedIn) {
            Navigator.pushNamed(context, addPoemRoute);
          } else {
            Navigator.pushNamed(context, loginRoute, arguments: Destination.AddPoem);
          }
        },
        tooltip: 'Add Poem',
        child: Icon(Icons.add),
      ),
    );
  }
}
