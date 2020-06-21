import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/logger.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

const MESSAGE_WRONG_EMAIL = "Wrong email.";
const MESSAGE_WRONG_PASSWORD = "Wrong password.";
const MESSAGE_TOO_MANY_TRIES = "Try again later or update your password.";
const MESSAGE_UNKNOWN_ERROR = "Oops, there was an error.";

class LoginViewModel extends BaseViewModel {
  static final _tag = "LoginViewModel";

  final UserModel userModel;
  final AuthService authService;

  String email;
  String password;
  String errorMessage = "";

  LoginViewModel(this.userModel, this.authService) : super(Rest());

  Future<bool> login() async {
    errorMessage = "";
    setState(Loading());
    try {
      AuthResult result = await authService.login(email, password);
      userModel.userId = result.user.uid;
      return true;
    } on PlatformException catch (e) {
      errorMessage = _getDisplayError(e.code);
      setState(Error());
      Logger.log(_tag, "login - $e");
    }
    return false;
  }

}

String _getDisplayError(String code) {
  switch(code) {
    case "ERROR_USER_NOT_FOUND":
      return MESSAGE_WRONG_EMAIL;
    case "ERROR_WRONG_PASSWORD":
      return MESSAGE_WRONG_PASSWORD;
    case "ERROR_TOO_MANY_REQUESTS":
      return MESSAGE_TOO_MANY_TRIES;
    default:
      return MESSAGE_UNKNOWN_ERROR;
  }
}