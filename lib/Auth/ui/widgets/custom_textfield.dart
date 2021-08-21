import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomTextfield(this.label, this.controller);
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: this.controller,
          decoration: InputDecoration(
            hintText:this.label ,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
