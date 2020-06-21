import 'package:drop_poet/common/destination.dart';
import 'package:drop_poet/common/styles.dart';
import 'package:drop_poet/common/validator.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/common/widget/button.dart';
import 'package:drop_poet/common/widget/container_page.dart';
import 'package:drop_poet/common/widget/form_field.dart';
import 'package:drop_poet/common/widget/loading_overlay.dart';
import 'package:drop_poet/common/widget/text_link.dart';
import 'package:drop_poet/register/register_view_model.dart';
import 'package:drop_poet/router.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Destination destination;

  const RegisterPage({Key key, this.destination}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(
              Provider.of<UserModel>(context, listen: false),
              Provider.of<AuthService>(context, listen: false),
              Provider.of<FirestoreService>(context, listen: false),
            ),
        child: Consumer<RegisterViewModel>(
          builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Sign Up'),
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
                          nextFocus: _usernameFocus,
                        ),
                        DPFormField(
                          label: "Username",
                          errorMessage: "Username must be between 8 and 20 characters",
                          isValid: (value) {
                            return Validator.isUsername(value);
                          },
                          onSave: (value) {
                            model.username = value;
                          },
                          currentFocus: _usernameFocus,
                          nextFocus: _passwordFocus,
                        ),
                        DPFormField(
                          label: "Password",
                          errorMessage: "Password must be at least 8 characters",
                          isValid: (value) {
                            return Validator.isPassword(value);
                          },
                          onSave: (value) {
                            model.password = value;
                          },
                          textInputType: TextInputType.visiblePassword,
                          currentFocus: _passwordFocus,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: PADDING_LARGE),
                          child: Builder(
                            builder: (context) => DPButton("SIGN UP", () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                bool success = await model.register();
                                if (success) {
                                  if (widget.destination == Destination.AddPoem) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(addPoemRoute, ModalRoute.withName(mapRoute));
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
                            text: "Already have an account? Login",
                            onPressed: () {
                              Navigator.pushNamed(context, loginRoute, arguments: widget.destination);
                            },
                          ),
                        )
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
