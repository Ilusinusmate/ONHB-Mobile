import 'package:flutter/material.dart';
import 'package:onhb_mobile/widgets/inputs/base_form_field.dart';

class EmailFormField extends StatelessWidget implements BaseFormField {
  const EmailFormField({
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
      return "Por favor insira um email";
    }
    if (!RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    ).hasMatch(value)) {
      return "Insira um email válido";
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
