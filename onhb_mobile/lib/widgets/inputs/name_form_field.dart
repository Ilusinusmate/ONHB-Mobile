import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/widgets/inputs/base_form_field.dart';

class TeamNameFormField extends StatelessWidget implements BaseFormField {
  const TeamNameFormField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  final String labelText;
  @override
  final TextEditingController controller;

  InputDecoration _buildDecoration(BuildContext context) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      labelStyle: Theme.of(context).textTheme.bodySmall,
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira o nome da equipe";
    }

    if (TeamStorageSystem.teamExistsSync(value)) {
      return "Nome da equipe já utilizado";
    }

    return null;
  }

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildDecoration(context),
      validator: _validator,
    );
  }
}
