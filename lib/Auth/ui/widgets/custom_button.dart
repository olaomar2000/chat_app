import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function function;
  String label;
  Color background;
  CustomButton(this.function, this.label,this.background);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      width: double.infinity,
      margin:EdgeInsets.symmetric(horizontal: 36, vertical: 5),
      child: RaisedButton(
        color: this.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37)),
        onPressed: () {
          function();
        },
        child: Text(label,style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
    );
  }
}
