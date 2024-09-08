import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_triple/flutter_triple.dart';

class RankingState {
  List<Map<String, dynamic>> topUsers = [];

  final DatabaseReference database = FirebaseDatabase.instance.ref("users");
}

class RankingStore extends Store<RankingState> {
  RankingStore() : super(RankingState());

  Future<void> init() async {
    setLoading(true);
    await fetchTopUsers();
    setLoading(false, force: true);
    update(state, force: true);
  }

  Future<void> fetchTopUsers() async {
    DataSnapshot snapshot = await state.database.get();

    if (snapshot.value != null && snapshot.value is Map) {
      Map<String, dynamic> usersMap =
          Map<String, dynamic>.from(snapshot.value as Map);

      List<Map<String, dynamic>> usersList = usersMap.entries
          .map((entry) {
            String? name = entry.value["nome"];
            if (name == null) {
              return null;
            }

            String formattedName = formatName(name);
            return {"nome": formattedName, "pontos": entry.value["pontos"]};
          })
          .where((user) => user != null)
          .toList()
          .cast<Map<String, dynamic>>();

      usersList.sort((a, b) => b['pontos'].compareTo(a['pontos']));

      update(state..topUsers = usersList.take(10).toList(), force: true);
    } else {
      update(state..topUsers = [], force: true);
    }
  }

  String formatName(String nomeCompleto) {
    List<String> partesNome = nomeCompleto.split(' ');

    if (partesNome.length > 1) {
      return '${partesNome[0]} ${partesNome[1]}';
    } else {
      return nomeCompleto;
    }
  }
}
