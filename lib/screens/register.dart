import 'dart:async';

import 'package:adviser/reusables/loading_circle.dart';
import 'package:adviser/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  //VARIABLES

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Show password
  bool showPassword = false;
  bool showConfirmPassword = false;

  //Email and password
  String email = '';
  String password = '';
  String confirmPassword = '';

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
                const SizedBox(height: 51),
                //Error message
                Text(
                  errorMessage,
                  style: TextStyle(
                      color: errorMessage == 'Usuario creado, inicie sesión.'
                          ? const Color(0xff00ff00)
                          : const Color(0xffff0000),
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
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
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      //Show/Hide Password button
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color:
                              //Change "Show password" icon color
                              showPassword
                                  ? const Color(0xffffffff)
                                  : Colors.black38,
                        ),
                        //Change "Showpassword bool"
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
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
                const SizedBox(height: 20),

                //Confirm password container
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0x77ffffff),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  //Confirm password textfield
                  child: TextField(
                    //Hide text
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      //Show/Hide Password button
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color:
                              //Change "Show password" icon color
                              showConfirmPassword
                                  ? const Color(0xffffffff)
                                  : Colors.black38,
                        ),
                        //Change "Showpassword bool"
                        onPressed: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                      ),
                      hintText: 'Confirmar contraseña',
                    ),
                    //Handle change
                    onChanged: (text) {
                      confirmPassword = text;
                    },
                  ),
                ),

                //Some space
                const SizedBox(height: 30),

                //Register button
                ElevatedButton.icon(
                  onPressed: () {
                    //Conditions for register and error messages
                    setState(() {
                      //Loading circle
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const LoadingCircle();
                          });
                      signUp();
                    });
                  },
                  icon: const Icon(
                    Icons.app_registration_rounded,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Registrarse',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ), // <-- Text
                ),

                //Some space
                const SizedBox(height: 20),

                //Go back button
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      //Go back to login
                      Navigator.pushNamed(context, '/login');
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Volver',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ), // <-- Text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//SignUp function
  Future signUp() async {
    //If all textfields are empty
    if (email == '' && password == '' && confirmPassword == '') {
      errorMessage = 'Completa los campos requeridos.';
    }
    //If password and confirm password don't match
    else if (password != confirmPassword) {
      //If password is empty
      if (password == '') {
        errorMessage = 'Ingresa una contraseña.';
      }
      //If confirm password is empty
      else if (confirmPassword == '') {
        errorMessage = 'Confirma tu contraseña.';
      }
      //Last condition
      else {
        errorMessage = 'Las contraseñas no coinciden.';
      }
    }
    //Check if password and confirm password are the same
    else if (password == confirmPassword) {
      try {
        //Create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          //Change error message
          errorMessage = 'Usuario creado, inicie sesión.';
          Timer(const Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                ModalRoute.withName("/login"));
          });
        });
      } on FirebaseAuthException catch (e) {
        // catch FirebaseAuthException errors here
        setState(() {
          errorMessage = e.code.replaceAll('-', ' ');

          //Translate to spanish
          if (errorMessage == 'email already in use') {
            errorMessage = 'Este email ya esta en uso.';
          }
          //..
          else if (errorMessage == 'invalid email') {
            errorMessage = 'Email inválido';
          }
          //..
          else if (errorMessage == 'weak password') {
            errorMessage = 'La contraseña debe tener al menos 6 caracteres';
          }
        });
      }
    }
    //Remove loading circle
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
