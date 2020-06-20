import 'package:drop_poet/common/destination.dart';
import 'package:drop_poet/common/styles.dart';
import 'package:drop_poet/common/validator.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/common/widget/button.dart';
import 'package:drop_poet/common/widget/container_page.dart';
import 'package:drop_poet/common/widget/form_field.dart';
import 'package:drop_poet/common/widget/loading_overlay.dart';
import 'package:drop_poet/common/widget/text_link.dart';
import 'package:drop_poet/login/login_view_model.dart';
import 'package:drop_poet/router.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Destination destination;

  const LoginPage({Key key, this.destination}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(
            Provider.of<UserModel>(context, listen: false), Provider.of<AuthService>(context, listen: false)),
        child: Consumer<LoginViewModel>(
          builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Log In'),
            ),
            body: DPLoadingOverlay(
              isLoading: model.state is Loading,
              child: SingleChildScrollView(
                child: DPContainerPage(
                  child: Form(
                    key: formKey,
                    child: (Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DPFormField(
                          label: "Email",
                          errorMessage: "Invalid email",
                          isValid: (value) {
                            return Validator.isEmail(value);
                          },
                          onSave: (value) {
                            model.email = value;
                          },
                          textInputType: TextInputType.emailAddress,
                          currentFocus: _emailFocus,
                          nextFocus: _passwordFocus,
                        ),
                        DPFormField(
                            label: "Password",
                            errorMessage: "Invalid password",
                            isValid: (value) {
                              return Validator.isPassword(value);
                            },
                            onSave: (value) {
                              model.password = value;
                            },
                            textInputType: TextInputType.visiblePassword,
                            currentFocus: _passwordFocus),
                        Align(
                            alignment: Alignment.centerRight,
                            child: DPTextLink(
                              text: "Forgot password?",
                              onPressed: () {
                                Navigator.pushNamed(context, forgotPasswordRoute);
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: PADDING_SMALL),
                          child: Builder(
                            builder: (context) => DPButton('LOG IN', () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                bool success = await model.login();
                                if (success) {
                                  if (widget.destination == Destination.AddPoem) {
                                    Navigator.of(context).pushNamedAndRemoveUntil(addPoemRoute, ModalRoute.withName(mapRoute));
                                  }
                                } else {
                                  final snackBar = SnackBar(content: Text(model.errorMessage));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              }
                            }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: PADDING_SMALL_EXTRA),
                          child: DPTextLink(
                              text: "No account? Sign up",
                              onPressed: () {
                                Navigator.pushNamed(context, registerRoute, arguments: widget.destination);
                              }),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
