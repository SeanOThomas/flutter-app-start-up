import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/logger.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class RegisterViewModel extends BaseViewModel {
  static final _tag = "RegisterViewModel";

  final UserModel userModel;
  final AuthService authService;
  final FirestoreService firestore;

  String username;
  String email;
  String password;
  String errorMessage = "";

  RegisterViewModel(this.userModel, this.authService, this.firestore) : super(Rest());

  Future<bool> register() async {
    errorMessage = "";
    setState(Loading());
    try {
      // 1. check if username is free
      bool isFree = await firestore.isUsernameFree(username);
      if (!isFree) {
        throw (PlatformException(code: "ERROR_USERNAME_TAKEN"));
      }
      // 2. register auth
      AuthResult result = await authService.register(email, password);
      userModel.userId = result.user.uid;

      // 3. add user to db
      await firestore.addUser(userModel.userId, email, username);

      return true;
    } on PlatformException catch (e) {
      errorMessage = _getDisplayError(e.code);
      setState(Error());
      Logger.log(_tag, "register - $e");
    }
    return false;
  }

  String _getDisplayError(String code) {
    switch (code) {
      case "ERROR_USERNAME_TAKEN":
        return "That username exists";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "That email exists";
      case "ERROR_INVALID_EMAIL":
        return "Badly formatted email";
      default:
        return "Oops, there was an error";
    }
  }
}
