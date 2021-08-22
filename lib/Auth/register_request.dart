import 'package:flutter/cupertino.dart';

class RegisterRequest {
String id;
String email;
String password;
String FName;
String LName;

RegisterRequest({
  @required this.id,
  @required this.email,

  @required this.FName,
  @required this.LName,

});
toMap(){
  return{
    'id':this.id,
    'email': this.email,
    'fName':this.FName,
    'lName':this.LName
  };


}
}