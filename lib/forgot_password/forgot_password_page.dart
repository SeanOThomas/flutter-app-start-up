import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/common/widget/loading_overlay.dart';
import 'package:drop_poet/common/widget/message_page.dart';
import 'package:drop_poet/forgot_password/forgot_password_entry.dart';
import 'package:drop_poet/forgot_password/forgot_password_model.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Forgot Password'),
      ),
      body: ChangeNotifierProvider<ForgotPasswordModel>(
        create: (context) => ForgotPasswordModel(Provider.of<FirestoreService>(context, listen: false)),
        child: Consumer<ForgotPasswordModel>(
          builder: (context, model, _) => Scaffold(
            body: DPLoadingOverlay(
                isLoading: model.state.runtimeType == Loading,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: getPage(context, model.state),
                )),
          ),
        ),
      ),
    );
  }

  Widget getPage(BuildContext context, ViewState state) {
    switch (state.runtimeType) {
      case Submitted:
        return DPMessagePage(
          "We sent an email with instructions.",
          header: "Success.",
          actionText: "Back to log in",
          onAction: () {
            Navigator.pop(context);
          },
        );
      default:
        return ForgotPasswordEntry();
    }
  }
}
