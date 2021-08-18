import 'dart:io';

import 'package:booking_app_client/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  ValueNotifier<bool> isShowPassword = ValueNotifier(true);
  final picker = ImagePicker();
  File? image;

  void changeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
    notifyListeners();
  }

  UserModel? userModel = UserModel(
    id: 'id',
    name: 'amal',
    lastName: 'barka',
    occupationGroup: 'mobile department',
    email: 'amalbarka1@gmail.com',
    imageUrl: '',
    phone: '52136631',
  );
  Future signIn(String email, String password) async {
    print(email);
    print(password);
  }

 Future resetPassword(String email) async {}

  Future logOut() async {
    print('log out');
  }

  Future updateUserData() async {}

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      //save imagefile in db
      notifyListeners();
    } else {
      print('No image selected.');
    }
  }
}
