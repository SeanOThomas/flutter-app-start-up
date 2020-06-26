import 'package:drop_poet/common/destination.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/common/widget/loading_overlay.dart';
import 'package:drop_poet/router.dart';
import 'package:drop_poet/search/no_location_page.dart';
import 'package:drop_poet/search/search_view_model.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(
          userModel
      ),
      child: Consumer<SearchViewModel>(
        builder: (context, model, _) => Scaffold(
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
          body: DPLoadingOverlay(
              isLoading: model.state is Starting || model.state is Loading, child: _getBody(model.state)),
        ),
      ),
    );
  }
}

Widget _getBody(ViewState viewState) {
  if (viewState is NoLocation) {
    return NoLocationPage();
  } else {
    return Container(
      child: Center(child: Text("Search")),
    );
  }
}
