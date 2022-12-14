// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowForm extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final Function(String) changeFunc;
  final TextEditingController? textEditingController;
  const ShowForm({
    Key? key,
    required this.iconData,
    required this.hint,
    required this.changeFunc,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 250,
      child: TextFormField(
        controller: textEditingController,
        onChanged: changeFunc,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
