import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/logger.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _MESSAGE_EMAIL_DOES_NOT_EXIST = "We can't find that email.";

class ForgotPasswordModel extends BaseViewModel {
  static final _TAG = "ForgotPasswordModel";

  final FirestoreService firestoreService;

  String email;
  String code;
  String password;
  String errorMessage = "";

  ForgotPasswordModel(this.firestoreService) : super(Rest());

  Future<bool> enterEmail() async {
    errorMessage = "";
    setState(Loading());
    var userId = await firestoreService.doesEmailExist(email);
    if (userId != null) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } catch (e) {
        Logger.log(_TAG, "send - error setting password code $e");
        setState(Rest());
        return false;
      }
      setState(Submitted());
      return true;
    }
    errorMessage = _MESSAGE_EMAIL_DOES_NOT_EXIST;
    setState(Rest());
    return false;
  }
}
