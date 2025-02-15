import 'package:flutter/material.dart';

class MyEditText extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;

  const MyEditText({
    super.key,
    required this.hint,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty){
            return "This field cannot be empty";

          }
          return null;
        },
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white, // Background color of the field
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // Default border color
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blue, // Border color when focused
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
