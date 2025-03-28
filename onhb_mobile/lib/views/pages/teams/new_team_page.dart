import 'package:flutter/material.dart';
import 'package:onhb_mobile/widgets/bars/back_app_bar.dart';
import 'package:onhb_mobile/widgets/forms/team_form.dart';

class NewTeamPage extends StatelessWidget {
  const NewTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(),
      body: Center(
        child: SizedBox(
          width: 700,
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(50),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(child: TeamForm(titleText: "Criar Nova Equipe")),
            ),
          ),
        ),
      ),
    );
  }
}
