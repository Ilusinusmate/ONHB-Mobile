import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/models/team.dart';
import 'package:onhb_mobile/processing/analyse_set_of_questions.dart';

class ResultRow extends StatelessWidget {
  final String teamName;
  final int position;
  final int maxPontuation;
  final int pontuation;

  const ResultRow({
    super.key,
    required this.teamName,
    required this.position,
    required this.maxPontuation,
    required this.pontuation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      elevation: 3,
      // color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: Text(
            "$position -",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              "$pontuation / $maxPontuation",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          title: Text(teamName, style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }
}

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final List<Team> _teams = AnalyseSetOfQuestions.getTeamsOrdered();
  final Map<String, int> _teamsPoints =
      AnalyseSetOfQuestions.getTeamsPontuation();
  final maxPontuation = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _teams.isEmpty
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Adicione uma Equipe"), Icon(Icons.add)],
                ),
              )
              : Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  itemCount: _teams.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25),
                  itemBuilder:
                      (context, index) => ResultRow(
                        teamName: _teams[index].teamName,
                        position: index + 1,
                        maxPontuation: maxPontuation,
                        pontuation: _teamsPoints[_teams[index].teamName]!,
                      ),
                ),
              ),
    );
  }
}
