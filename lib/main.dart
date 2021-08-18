import 'package:booking_app_client/providers/auth_provider.dart';
import 'package:booking_app_client/providers/main_provider.dart';
import 'package:booking_app_client/screens/login_screen.dart';
import 'package:booking_app_client/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(
          value: MainProvider()
            ..getdevices()
            ..getcategory()
            ..getmymydevises()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) => MaterialApp(
          title: 'Booking App Employee',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: snapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : LoginScreen()),
    );
  }
}
