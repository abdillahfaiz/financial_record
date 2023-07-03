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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xff212436),
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white,),
        controller: formController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          border: InputBorder.none,
        ),
        keyboardType: typeInput,
      ),
    );
  }
}
