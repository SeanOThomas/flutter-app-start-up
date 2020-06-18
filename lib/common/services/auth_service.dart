import 'package:drop_poet/common/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _tag = "AuthService";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> login(String email, String password) {
    Logger.log(_tag, 'login - $email $password');
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthResult> register(String email, String password) {
    Logger.log(_tag, 'register - $email $password');
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    return _auth.signOut();
  }

  Stream<FirebaseUser> getUserStream() {
    return _auth.onAuthStateChanged;
  }

  Future<void> resetPassword(String password) async {

  }
}
