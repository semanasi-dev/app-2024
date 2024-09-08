import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CongratulationsState {
  User? user;
  String? total;
}

class CongratulationsStore extends Store<CongratulationsState> {
  CongratulationsStore() : super(CongratulationsState());

  void init() async {
    super.initStore();
    setLoading(true);
    state.total = await totalScore();
    setLoading(false, force: true);
    update(state, force: true);
  }

  Future<String> totalScore() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref('users');

    DatabaseReference userRef = database.child(state.user!.uid);
    DataSnapshot snapshot = await userRef.get();

    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    return data['pontos'].toString();
  }
}
