import 'package:adviser/reusables/loading_circle.dart';
import 'package:adviser/tools/user_operations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Firebase database instance
  FirebaseDatabase database = FirebaseDatabase.instance;

  //Show password
  bool showpassword = false;

  //Email and password
  String email = '';
  String password = '';

  //Error message
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          //Background color
          child: Container(
            //Make container's height same as (context) screen
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff000000), Color(0xff252525)],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            )),

            //Login container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Adviser Logo
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    'images/AdviserLogo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),

                //Some space
                const SizedBox(height: 85),

                //Error message
                Text(
                  errorMessage,
                  style: const TextStyle(
                      color: Color(0xffff0000),
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
                //Some space
                const SizedBox(height: 10),
                //Email container
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0x77ffffff),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  //Email textfield
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Email',
                    ),
                    //Handle change
                    onChanged: (text) {
                      email = text;
                    },
                    //Enter key functionality
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //Some space
                const SizedBox(height: 20),
                //Password container
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0x77ffffff),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  //Password textfield
                  child: TextField(
                    //Hide text
                    obscureText: !showpassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      //Show/Hide Password button
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color:
                              //Change "Show password" icon color
                              showpassword
                                  ? const Color(0xffffffff)
                                  : Colors.black38,
                        ),
                        //Change "Showpassword bool"
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                      ),
                      hintText: 'Contraseña',
                    ),
                    //Handle change
                    onChanged: (text) {
                      password = text;
                    },
                  ),
                ),
                //Some space
                const SizedBox(height: 30),
                //Login button
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      //Loading circle
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const LoadingCircle();
                          });
                      login();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ), // <-- Text
                ),

                //Some space
                const SizedBox(height: 20),

                //Don't have account? - Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                    //Some space
                    const SizedBox(width: 20),
                    //Register button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      icon: const Icon(
                        Icons.app_registration_rounded,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Registrate',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),
                    //Some space
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(width: 20),
                Container(
                  margin: const EdgeInsets.only(
                    left: 0,
                    top: 30,
                    right: 0,
                    bottom: 0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/resetpassword');
                    },
                    child: const Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Color(0xffffffff),
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Login function
  Future login() async {
    try {
      //Login
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //Access to userdata
      DatabaseReference userData =
          database.ref('users/${email.replaceAll('.', '')}');

      //Snap to check if user is new
      final newUser = await database
          .ref()
          .child('users/${email.replaceAll('.', '')}')
          .get();

      //Check if user exists
      if (newUser.exists) {
        //Go to create profile
        if (context.mounted) {
          Navigator.pushNamed(context, '/createprofilefirsttime');
        }
      }
      //If user doesn't exist, create user database and go to tutorial
      else if (!newUser.exists) {
        //Set all user variables
        userData.set(UserOperations().createUser(true, email, '', '', '', ''));

        //Go to App tutorial
        if (context.mounted) {
          Navigator.pushNamed(context, '/tutorialnewuser');
        }
      }
    }
    //Error
    on FirebaseException catch (e) {
      //Error messages
      setState(() {
        errorMessage = e.code;
        if (e.code == 'invalid-email') {
          errorMessage = 'Email inválido.';
        } else if (e.code == 'invalid-credential') {
          errorMessage = 'Email o contraseña incorrectos.';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Bloqueado temporalmente | Intente de nuevo mas tarde';
        }
      });

      //Remove loading circle
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
