import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/models/team.dart';
import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/widgets/inputs/email_form_field.dart';
import 'package:onhb_mobile/widgets/inputs/name_form_field.dart';

class TeamForm extends StatefulWidget {
  final String titleText;
  const TeamForm({super.key, required this.titleText});

  @override
  State<TeamForm> createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await TeamStorageSystem.saveTeam(
        Team(teamName: _nameController.text, questions: <int, int>{}),
      );
      Future.delayed(Duration(milliseconds: 5), () {
        Navigator.pop(context);
      });
    }
  }

  Text _buildTitleText(BuildContext context) {
    return Text(
      widget.titleText,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  ElevatedButton _buildSubmitBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).primaryColor,
        ),
      ),
      child: Text(
        "Adicionar",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: _buildTitleText(context)),

          SizedBox(height: 35),

          EmailFormField(controller: _emailController, labelText: "Email"),

          SizedBox(height: 20),

          TeamNameFormField(
            controller: _nameController,
            labelText: "Nome da Equipe",
          ),

          SizedBox(height: 20),
          Center(child: _buildSubmitBtn(context)),
        ],
      ),
    );
  }
}
