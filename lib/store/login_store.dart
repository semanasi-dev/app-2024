import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:sasiqrcode/provider/user_model.dart';
import 'package:sasiqrcode/routes/routes.dart';

class LoginState {
  final DatabaseReference database = FirebaseDatabase.instance.ref('users');

  var loginError = false;

  UserModel? user;
}

class LoginStore extends Store<LoginState> {
  LoginStore() : super(LoginState());

  Future<UserCredential?> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    UserCredential login =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    return login;
  }

  Future<void> checkIfUserExist(UserCredential login) async {
    if (login.user != null) {
      state.user!.setUserUid(login.user);

      DatabaseReference userRef = state.database.child(login.user!.uid);

      DataSnapshot snapshot = await userRef.get();

      if (!snapshot.exists) {
        await userRef.set({
          'nome': login.user!.displayName,
          'email': login.user!.email,
          'pontos': 0,
        });
      }
    }
  }

  Future<void> onClickLogin(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    setLoading(true);
    UserCredential? login = await signInWithGoogle();
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    if (login == null) {
      state.loginError = true;
      setLoading(false, force: true);
      update(state, force: true);
      return;
    }
    await checkIfUserExist(login);
    RouterUtils().navigatorToHome(context);
    setLoading(true);
    update(state, force: true);
  }
}
