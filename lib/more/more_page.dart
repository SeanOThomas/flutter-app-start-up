import 'package:drop_poet/common/widget/list_tile.dart';
import 'package:drop_poet/more/sign_out_dialog.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      key: _scaffoldKey,
      body: ListView.separated(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return NNListTile(
                title: "Sign Out",
                icon: Icon(Icons.directions_run),
                onPressed: () {
                  if (userModel.isLoggedIn) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SignOutDialog(
                            scaffoldKey: _scaffoldKey,
                          );
                        });
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("You're not signed in")));
                  }
                },
              );
            default:
              throw Exception("invalid index");
          }
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
