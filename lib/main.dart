import 'package:adviser/screens/create_profile_first_time.dart';
import 'package:adviser/screens/login.dart';
import 'package:adviser/screens/register.dart';
import 'package:adviser/screens/reset_password.dart';
import 'package:adviser/screens/tutorial_professional_user.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //Make sure every function needed is initialized
  WidgetsFlutterBinding.ensureInitialized();

  //Appcheck

  //Platform Android then initialize Firebase
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCUAiOsvMGr9qz11wSglyXpl_-4RmCDJYM',
    appId: '1:380278720194:android:717f396f0fe8c59838dd5b',
    messagingSenderId: '380278720194',
    projectId: 'adviser-app-firebase',
    storageBucket: 'adviser-app-firebase.appspot.com',
  ));

  //Initialize AppCheck
  await FirebaseAppCheck.instance.activate(
    // argument for `webProvider`
    //→webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    //→appleProvider: AppleProvider.appAttest,
  );

  //RunApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Routing handler
      onGenerateRoute: (settings) {
        if (settings.name == "/createprofilefirsttime") {
          return PageRouteBuilder(
              settings:
                  settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
              pageBuilder: (_, __, ___) => const CreateProfileFirstTime(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c));
        }
        // Unknown route
        return MaterialPageRoute(
            builder: (_) => const CreateProfileFirstTime());
      },
      //Theme
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xff40ddff),
          scaffoldBackgroundColor: const Color(0xff000000)),
      debugShowCheckedModeBanner: false,

      //Home
      home: const Login(),
      //Asign routes
      routes: {
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/resetpassword': (context) => const ResetPassword(),
        '/createprofilefirsttime': (context) => const CreateProfileFirstTime(),
        '/tutorialnewuser': (context) => const TutorialProfessionalUser(),
      },
    );
  }
}
