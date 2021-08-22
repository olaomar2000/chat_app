import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String fName;
  String lName;
  UserModel({
    @required this.id,
    @required this.email,

    @required this.fName,
    @required this.lName,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.fName = map['fName'];
    this.lName = map['lName'];
  }
}