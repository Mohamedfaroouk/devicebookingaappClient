import 'package:booking_app_client/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileImageScreen extends StatelessWidget {
  const ProfileImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Image'),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, value, child) => Center(
          // must chane image.file to image.network 
          //id store the image in database

          child: value.userModel!.imageUrl == ''
              ? Image.asset('assets/images/profile.png')
              : Image.network(value.userModel!.imageUrl),
        ),
      ),
    );
  }
}
