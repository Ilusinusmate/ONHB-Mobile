// ignore_for_file: unused_element

import 'package:flutter/material.dart';

abstract class BaseFormField extends StatelessWidget {
  const BaseFormField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final String labelText;
  final TextEditingController controller;

  InputDecoration _buildDecoration(BuildContext context);

  String? _validator(String? value);

  @override
  TextFormField build(BuildContext context);
}
