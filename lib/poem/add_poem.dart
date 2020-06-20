import 'package:drop_poet/common/widget/container_page.dart';
import 'package:drop_poet/poem/add_poem_field.dart';
import 'package:drop_poet/poem/add_poem_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPoemPage extends StatefulWidget {
  @override
  _AddPoemPageState createState() => _AddPoemPageState();
}

class _AddPoemPageState extends State<AddPoemPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _placeFocus = FocusNode();
  final FocusNode _wordsFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPoemViewModel>(
      create: (context) => AddPoemViewModel(),
      child: Consumer<AddPoemViewModel>(
        builder: (context, model, _) => Scaffold(
            body: SingleChildScrollView(
          child: DPContainerPage(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Form(
                child: Column(
                  children: [
                    AddPoemField(
                      hintText: "Title",
                      currentFocus: _titleFocus,
                      nextFocus: _placeFocus,
                    ),
                    AddPoemField(
                      hintText: "Place",
                      currentFocus: _placeFocus,
                      nextFocus: _wordsFocus,
                    ),
                    AddPoemField(
                      hintText: "Beautiful words...",
                      currentFocus: _wordsFocus,
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
