import 'package:flutter/cupertino.dart';

class RegisterRequest {

String email;
String password;
String FName;
String LName;

RegisterRequest({
  @required this.email,
  @required this.password,
  @required this.FName,
  @required this.LName,

});
toMap(){
  return{
    'email': this.email,
    'fName':this.FName,
    'lName':this.LName
  };


}
}