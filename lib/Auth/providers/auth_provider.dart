import 'dart:io';

import 'package:firebase_gsg/Auth/helpers/firestorage_helper.dart';
import 'package:firebase_gsg/Auth/helpers/firestore_helper.dart';
import 'package:firebase_gsg/Auth/helpers/sp_helper.dart';
import 'package:firebase_gsg/Auth/register_request.dart';
import 'package:firebase_gsg/Auth/helpers/auth_helper.dart';
import 'package:firebase_gsg/chats/user.dart';
import '../../chats/chat_page.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_gsg/Auth/ui/singup.dart';
import 'package:firebase_gsg/Auth/user_model.dart';
import 'package:firebase_gsg/chats/home_page.dart';
import 'package:firebase_gsg/chats/profile.dart';
import 'package:firebase_gsg/services/custom_dialoug.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

import '../../country_model.dart';

class AuthProvider extends ChangeNotifier {


  List<UserModel> users;
  String myId;

  getAllUsers() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id == myId);
    notifyListeners();
  }



// TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController FName = TextEditingController();
  TextEditingController LName = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();

  fillControllers() {
    emailController.text = user.email;
    FName.text = user.fName;
    LName.text = user.lName;
    countryController.text = user.country;
    cituController.text = user.city;
  }

  File updatedFile;
  captureUpdateProfileImage() async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(updatedFile);
    }
    UserModel userModel = imageUrl == null
        ? UserModel(
            city: cituController.text,
            country: countryController.text,
            fName: FName.text,
            lName: LName.text,
            id: user.id)
        : UserModel(
            city: cituController.text,
            country: countryController.text,
            fName: FName.text,
            lName: LName.text,
            id: user.id,
            imageUrl: imageUrl ?? user.imageUrl);

    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFirestore();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }

  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFirestore() async {
    List<CountryModel> countries =
        await FirestoreHelper.firestoreHelper.getAllCountries();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }


  sendImageToChat([String message]) async {
//     Directory directory = await getApplicationDocumentsDirectory();
//
//     bool hasPermissions = await AudioRecorder.hasPermissions;
//
// // Get the state of the recorder
//     bool isRecording = await AudioRecorder.isRecording;
//
// // Start recording
//     await AudioRecorder.start(
//         path: directory.path + '/aaa',
//         audioOutputFormat: AudioOutputFormat.AAC);
//
//     await Future.delayed(Duration(seconds: 5));
//     Recording recording = await AudioRecorder.stop();
//     print(
//         "Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");

    PickedFile  file = await ImagePicker().getImage(source: ImageSource.gallery);
    File file2 = File(file.path);
    String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadImage(file2, 'chats');
    FirestoreHelper.firestoreHelper.addMessageToFirestore({
      'userId': this.myId,
      'dateTime': DateTime.now(),
      'message': message ?? '',
      'imageUrl': imageUrl
    });
  }



///////////////////////////////////////////////////
  ///upload Image
  File file;
  selectFile() async {
    PickedFile imageFile =
        (await ImagePicker().getImage(source: ImageSource.gallery));
    this.file = File(imageFile.path);
    notifyListeners();
  }

  UserModel user;
  getUserFromFirestore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);

    notifyListeners();
  }




  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }



  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();

    if (isLoggedIn) {
      this.myId = AuthHelper.authHelper.getUserId();
      getAllUsers();
      RouteHelper.routeHelper.goToPageWithReplacement(UsersPage.routeName);
    } else {
      RouteHelper.routeHelper.goToPageWithReplacement(singup.routeName);
    }
  }

  register() async {
    try {
      UserCredential userCredinial = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      String imageUrl =
          await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
          id: userCredinial.user.uid,
          imageUrl: imageUrl,
          //city: selectedCity,
          //country: selectedCountry.name,
          email: emailController.text,
          LName: LName.text,
          FName: FName.text);
      await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
      //await SPHelper.spHelper.setUser(registerRequest.id);
      await AuthHelper.authHelper.verifyEmail();
      //await AuthHelper.authHelper.logout();
      // tabController.animateTo(1);
    } on Exception catch (e) {
      print('eeeeeeeeeeeeeeeeee');
    }
    RouteHelper.routeHelper.goToPage(login.routeName);

    resetControllers();
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    RouteHelper.routeHelper.goToPageWithReplacement(login.routeName);
  }

  login1() async {
    UserCredential userCredinial = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredinial.user.uid);
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    //  if (isVerifiedEmail) {
    print('done');
    RouteHelper.routeHelper.goToPageWithReplacement(UsersPage.routeName);
    // } else {
    // CustomDialoug.customDialoug.showCustomDialoug(
    //   'You have to verify your email, press ok to send another email',
    // sendVericiafion);
    //  }
    resetControllers();
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }
}
