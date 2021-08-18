import 'package:booking_app_client/providers/auth_provider.dart';
import 'package:booking_app_client/screens/forgot_password_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/home_screen.dart';
import 'package:booking_app_client/widgets_model/custom_elevated_button.dart';
import 'package:booking_app_client/widgets_model/custom_text.dart';
import 'package:booking_app_client/widgets_model/custom_text_form_field.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  void submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    isLoading = true;
    Provider.of<AuthProvider>(context,listen: false)
        .signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    )
        .then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DoubleBack(
          child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  color: KPrimaryColor,
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      CustomText(
                        text: 'Login Employee',
                        color: Colors.white,
                        fontSize: 33,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: size.height * 0.7,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'example@gmail.com',
                                isPassword: false,
                                prefixIcon: Icons.email,
                                suffixIcon: null,
                                type: TextInputType.emailAddress,
                                validate: (String? val) {
                                  if (val!.isEmpty || !val.contains('@')) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Consumer<AuthProvider>(
                                builder: (BuildContext context, value,
                                        Widget? child) =>
                                    CustomTextFormField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  hint: "Minimum 6 characters",
                                  isPassword:
                                      value.isShowPassword.value ? true : false,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: IconButton(
                                    icon: value.isShowPassword.value
                                        ? Icon(Icons.visibility_off_rounded)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      //change show password state
                                      value.changeShowPassword();
                                    },
                                  ),
                                  type: TextInputType.text,
                                  validate: (String? val) {
                                    if (val!.isEmpty || val.length < 6) {
                                      return "Password is too short";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                                  },
                                  child: CustomText(
                                    text: 'Forgot Password?',
                                    alignment: Alignment.centerRight,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              isLoading
                                  ? CircularProgressIndicator()
                                  : CustomElevatedButton(
                                      text: 'LOGIN',
                                      onPressed: () => submit(context),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
