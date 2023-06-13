// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormCreateData extends StatelessWidget {
  TextEditingController formController = TextEditingController();
  String hintText;
  TextInputType typeInput;
  FormCreateData({
    Key? key,
    required this.hintText,
    required this.formController,
    required this.typeInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: formController,
      decoration: InputDecoration(hintText: hintText),
      keyboardType: typeInput,
    );
  }
}
