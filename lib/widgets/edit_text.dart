import 'package:flutter/material.dart';

class MyEditText extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  const MyEditText(
      {super.key, required this.hint, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
