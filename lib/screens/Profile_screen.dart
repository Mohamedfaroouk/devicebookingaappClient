import 'package:booking_app_client/providers/auth_provider.dart';
import 'package:booking_app_client/screens/edit_profile_screen.dart';
import 'package:booking_app_client/screens/profile_image_screen.dart';
import 'package:booking_app_client/widgets_model/custom_list_tile_profile.dart';
import 'package:booking_app_client/widgets_model/custom_text.dart';
import 'package:booking_app_client/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  Future<dynamic> pickedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Consumer<AuthProvider>(
              builder: (context, value, child) => AlertDialog(
                title: Text('Choose the profile image'),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.camera,
                          color: KPrimaryColor,
                        ),
                        title: Text('From Camera'),
                        onTap: () async {
                          await value.pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.photo_library,
                          color: KPrimaryColor,
                        ),
                        title: Text('From Gallery'),
                        onTap: () async {
                          await value.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Profile Screen'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditProfileScreen())),
                child: CustomText(
                  text: 'Edit',
                  alignment: Alignment.center,
                  color: Colors.white,
                ))
          ],
        ),
        body: Consumer<AuthProvider>(
          builder: (context, value, child) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(clipBehavior: Clip.none, children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProfileImageScreen())),
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey)),
                        child: //check if image not equal null to show image saved in db
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: value.userModel!.imageUrl == ''
                                    ? Image.asset(
                                        'assets/images/profile.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        value.userModel!.imageUrl,
                                        fit: BoxFit.fill,
                                      ))),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -10,
                    child: Container(
                        //padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40)),
                        child: IconButton(
                          onPressed: () {
                            pickedDialog(context);
                          },
                          icon: Icon(Icons.edit),
                        )),
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                CustomListTileProfile(
                  leading: Icon(Icons.person),
                  title: 'Name',
                  subtitle:
                      value.userModel!.name + ' ' + value.userModel!.lastName,
                ),
                CustomListTileProfile(
                  leading: Icon(Icons.group_rounded),
                  title: 'Occupation Group',
                  subtitle: value.userModel!.occupationGroup,
                ),
                CustomListTileProfile(
                  leading: Icon(Icons.email),
                  title: 'Email',
                  subtitle: value.userModel!.email,
                ),
                CustomListTileProfile(
                  leading: Icon(Icons.phone),
                  title: 'Phone',
                  subtitle: value.userModel!.phone,
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                  onPressed: () => Provider.of<AuthProvider>(context).logOut(),
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  label: CustomText(
                    text: 'Log Out',
                  ),
                )
              ]),
            ),
          ),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
