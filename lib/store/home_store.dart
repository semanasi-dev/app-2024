import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeState {
  bool? jaValidouLinkedin;

  String? total;

  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  User? userUid;
  final linkedinController = TextEditingController();
}

class HomeStore extends Store<HomeState> {
  HomeStore() : super(HomeState());

  void init() async {
    super.initStore();
    setLoading(true);
    state.total = await totalScore();
    state.jaValidouLinkedin = await checkIfUserValidateLinkedin();
    setLoading(false);
    update(state, force: true);
  }

  Future<bool> checkIfUserValidateLinkedin() async {
    try {
      DatabaseReference userRef = state._database.child(state.userUid!.uid);

      DataSnapshot snapshot = await userRef.get();

      return snapshot.child('linkedin').exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> addLinkedin(String linkedinProfile) async {
    DatabaseReference user = state._database.child(state.userUid!.uid);

    DataSnapshot snapshot = await user.get();

    int currentPoints = snapshot.child('pontos').value as int? ?? 0;
    int updatedPoints = currentPoints + 50;

    await user.update({
      'pontos': updatedPoints,
      'linkedin': linkedinProfile,
    });
    state.total = await totalScore();
  }

  Future<String> totalScore() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref('users');

    DatabaseReference user = database.child(state.userUid!.uid);
    DataSnapshot snapshot = await user.get();

    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

    return data['pontos'].toString();
  }
}
