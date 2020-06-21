import 'package:drop_poet/common/styles.dart';
import 'package:drop_poet/common/validator.dart';
import 'package:drop_poet/common/widget/button.dart';
import 'package:drop_poet/common/widget/container_page.dart';
import 'package:drop_poet/common/widget/description_text.dart';
import 'package:drop_poet/common/widget/form_field.dart';
import 'package:drop_poet/forgot_password/forgot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordEntry extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    ForgotPasswordModel model = Provider.of<ForgotPasswordModel>(context);
    return DPContainerPage(
      topPadding: PADDING_LARGE,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DPDescriptionText("No probs. We'll email you a link to reset your password."),
            Padding(
              padding: EdgeInsets.only(top: PADDING_SMALL),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      DPFormField(
                        label: "Email",
                        initial: model.email,
                        errorMessage: "Invalid email",
                        isValid: (value) {
                          return Validator.isEmail(value);
                        },
                        onSave: (value) {
                          model.email = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        currentFocus: _emailFocus,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: PADDING_LARGE),
                        child: DPButton("SEND", () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            bool success = await model.enterEmail();
                            if (!success) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text(model.errorMessage)));
                            }
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
