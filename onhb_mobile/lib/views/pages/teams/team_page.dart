import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/views/pages/teams/new_team_page.dart';
import 'package:onhb_mobile/widgets/forms/team_question_answer.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  List<String> _teamNames = [];

  @override
  void initState() {
    super.initState();
    _loadTeamNames();
  }

  void _loadTeamNames() async {
    var loadedTeamNames =
        (await TeamStorageSystem.getTeamsList())
            .map((team) => team.teamName)
            .toList();

    setState(() {
      _teamNames = loadedTeamNames;
    });
  }

  void _setTeamGabarito(String teamName) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GabaritoEditPage(teamName: teamName),
      ),
    );

    if (result == null) return;

    setState(() {});
  }

  void _deleteTeam(String teamName) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
            'Tem certeza de que deseja excluir a equipe "$teamName"?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete != true) return;

    await TeamStorageSystem.deleteTeamSync(teamName);
    setState(() {
      _teamNames.removeWhere((value) => value == teamName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTeamPage()),
          );

          // Recarrega os dados quando a página retorna
          _loadTeamNames();
        },
        child: const Icon(Icons.add),
      ),
      body:
          _teamNames.isEmpty
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Adicione uma Equipe"),
                    const Icon(Icons.add),
                  ],
                ),
              )
              : Center(
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ListView.separated(
                      itemCount: _teamNames.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder:
                          (context, idx) => Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                _teamNames[idx],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.fontSize,
                                ),
                              ),
                              leading: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed:
                                    () => _setTeamGabarito(_teamNames[idx]),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () => _deleteTeam(_teamNames[idx]),
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
    );
  }
}
