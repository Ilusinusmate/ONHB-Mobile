import 'package:hive_flutter/hive_flutter.dart';

part 'team.g.dart';

@HiveType(typeId: 33)
class Team {
  @HiveField(0)
  final String teamName;

  @HiveField(1)
  Map<int, int> questions;

  Team({required this.teamName, required this.questions});

  @override
  String toString() {
    return "Team Name: $teamName, Questions: $questions";
  }
}
