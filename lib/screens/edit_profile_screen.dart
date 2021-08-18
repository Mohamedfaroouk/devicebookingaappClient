import 'package:booking_app_client/providers/auth_provider.dart';
import 'package:booking_app_client/screens/Profile_screen.dart';
import 'package:booking_app_client/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app_client/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  void update(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateUserData()
          .then((value) {
        setState(() {
          isLoading = false;
        });
        return Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred, please try again'),
          duration: Duration(seconds: 5)));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) => Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAddTextFormField(
                    initialValue: value.userModel!.name,
                    label: 'Name',
                    onSave: (String? val) {
                      value.userModel!.name = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the name';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAddTextFormField(
                    initialValue: value.userModel!.lastName,
                    label: 'Last Name',
                    onSave: (String? val) {
                      value.userModel!.lastName = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the Last name';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAddTextFormField(
                    initialValue: value.userModel!.occupationGroup,
                    label: 'Occupation Group',
                    onSave: (String? val) {
                      value.userModel!.occupationGroup = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the OccupationGroup';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAddTextFormField(
                    initialValue: value.userModel!.phone,
                    label: 'Phone',
                    keyboardType: TextInputType.number,
                    onSave: (String? val) {
                      value.userModel!.phone = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the Phone';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'Update',
                          onPressed: () => update(context),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
