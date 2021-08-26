import 'package:flutter/cupertino.dart';

class RegisterRequest {
String id;
String email;
String password;
String city;
String country;
String FName;
String LName;
String imageUrl;
RegisterRequest({
  @required this.id,
  @required this.email,
  @required this.city,
  @required this.country,
  @required this.imageUrl,
  @required this.FName,
  @required this.LName,

});
toMap(){
  return{
    'id':this.id,
    'email': this.email,
    'fName':this.FName,
    'lName':this.LName,
    'city': this.city,
    'country': this.country,

    'imageUrl': this.imageUrl
  };


}
}
