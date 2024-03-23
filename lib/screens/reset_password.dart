import 'package:adviser/reusables/loading_circle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  //VARIABLES

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  //Email
  String email = '';

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
                const SizedBox(height: 218),
                //Some space
                //Error message
                Text(
                  errorMessage,
                  style: TextStyle(
                      color: errorMessage ==
                              'Revisa tu correo para cambiar tu contraseña'
                          ? const Color(0xff00ff00)
                          : const Color(0xffff0000),
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
                      resetPassword();
                    });
                  },
                  icon: const Icon(
                    Icons.send,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Enviar',
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

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        //Change error message
        errorMessage = 'Revisa tu correo para cambiar la contraseña.';
      });
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code.replaceAll('-', ' ');

      setState(() {
        //Translate
        if (errorMessage == 'invalid email') {
          errorMessage = 'Email inválido.';
        }
      });
    }
    //Remove loading circle
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
