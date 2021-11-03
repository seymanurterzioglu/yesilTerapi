import 'package:flutter/material.dart';


class EditForm extends StatelessWidget {
  final String? label;
  final String? text;
  EditForm({
    Key? key,
    this.label,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        border: InputBorder.none,
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }
}
