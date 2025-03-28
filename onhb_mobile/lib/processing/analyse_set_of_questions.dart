import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/data/models/team.dart';

class AnalyseSetOfQuestions {
  static late Map<int, int> _gabarito;

  AnalyseSetOfQuestions() {
    _initializeGabarito();
  }

  static Future<void> _initializeGabarito() async {
    _gabarito = GabaritoStorageSystem.getGabarito();
  }

  static int compareQuestions(Map<int, int> questions) {
    int res = 0;
    for (final entrie in questions.entries) {
      if (_gabarito[entrie.key] == entrie.value) res++;
    }
    return res;
  }

  static List<Team> orderTeamsByPoints(List<Team> teams) {
    return List<Team>.from(teams)
      ..sort(
        (a, b) => compareQuestions(b.questions).compareTo(compareQuestions(a.questions)),
      );
  }

  static List<Team> getTeamsOrdered() {
    _initializeGabarito();
    var teams = TeamStorageSystem.getTeamsListSync();
    return orderTeamsByPoints(teams);
  }

  static Map<String, int> getTeamsPontuation() {
    _initializeGabarito();
    var teams = TeamStorageSystem.getTeamsListSync();
    var result = <String, int>{};
    for (final team in teams) {
      result[team.teamName] = compareQuestions(team.questions);
    }
    return result;
  }
}
