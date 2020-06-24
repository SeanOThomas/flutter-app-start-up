import 'package:drop_poet/common/styles.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignOutDialog extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SignOutDialog({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return AlertDialog(
      title: Text('Sign Out'),
      content: const Text("Are you sure you want to sign out?"),
      actions: <Widget>[
        FlatButton(
          child: const Text(
            'No',
            style: TextStyle(color: Color(PRIMARY_DARK)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Text('Yes', style: TextStyle(color: Color(PRIMARY_DARK))),
          onPressed: () async {
            Navigator.of(context).pop();
            await userModel.signOut();
            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You're signed out")));
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("You're signed out")));
          },
        )
      ],
    );
  }
}
