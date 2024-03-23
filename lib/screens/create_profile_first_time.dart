import 'dart:io';

import 'package:adviser/reusables/loading_circle.dart';
import 'package:adviser/tools/user_operations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CreateProfileFirstTime extends StatefulWidget {
  const CreateProfileFirstTime({super.key});

  @override
  State<CreateProfileFirstTime> createState() => _CreateProfileFirstTimeState();
}

class _CreateProfileFirstTimeState extends State<CreateProfileFirstTime> {
  //Loading variable used for Absorber
  bool nowLoading = false;
  //Input profile variables
  PlatformFile? pickedFile;
  String name = '';
  String lastName = '';
  String profession = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    //Upload picture icon
    Widget uploadPictureIcon = const SizedBox(
      height: 200,
      width: 200,
      child: Icon(
        Icons.upload_rounded,
        color: Color(0xffffffff),
        size: 120,
      ),
    );

    //Disable back button
    return PopScope(
      canPop: false,
      //Absorb touch screen
      child: AbsorbPointer(
        //Absorb unputs
        absorbing: nowLoading,

        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Crea tu perfil',
              style: TextStyle(color: Color(0xffffffff)),
            ),
            backgroundColor: const Color(0xff000000),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Center(
                //Background color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Some space
                    const SizedBox(height: 20),

                    //Profil picture container
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        //Upload picture function
                        selectPicture();
                      },
                      //Container with a Circleavatar inside a Container
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff151515),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55ffffff),
                              blurRadius: 20,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: pickedFile == null
                            //Shows the Upload logo by default
                            ? uploadPictureIcon
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                child: CircleAvatar(
                                  //Uploaded picture
                                  backgroundImage: Image.file(
                                    File(pickedFile!.path!),
                                    fit: BoxFit.cover,
                                  ).image,
                                ),
                              ),
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 20),

                    //Clic to upload message
                    const Text(
                      'Imagen de perfil',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 15,
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 20),

                    //Name textField
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0x77ffffff),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      //Email textfield
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Nombre*',
                        ),
                        //Handle change
                        onChanged: (text) {
                          name = text;
                          //Can upload checker
                          canUpload();
                        },
                        //Enter key functionality
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 10),

                    //Lastname textField
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0x77ffffff),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      //Email textfield
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Apellido*',
                        ),
                        //Handle change
                        onChanged: (text) {
                          lastName = text;
                          //Can upload checker
                          canUpload();
                        },
                        //Enter key functionality
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 10),

                    //Profession textField
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0x77ffffff),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      //Email textfield
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Profesión*',
                        ),
                        //Handle change
                        onChanged: (text) {
                          profession = text;
                          //Can upload checker
                          canUpload();
                        },
                        //Enter key functionality
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 10),

                    //Description textField
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0x77ffffff),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      //Email textfield
                      child: TextField(
                        //Multiline
                        maxLines: 10,
                        maxLength: 320,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Descripción',
                        ),
                        //Handle change
                        onChanged: (text) {
                          description = text;
                          //Can upload checker
                          canUpload();
                        },
                        //Enter key functionality
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    //Some space
                    const SizedBox(height: 10),

                    Column(
                      children: [
                        //Hint 1
                        const Text(
                          'Los campos marcados con * son obligatorios.',
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 15),
                        ),

                        //Hint 2 when try to upload incompleted data
                        Text(
                          canUpload()
                              ? ' Listo para subir'
                              : ' Datos incompletos',
                          style: TextStyle(
                              color: canUpload()
                                  ? const Color(0xff00ff00)
                                  : const Color(0xffff0000),
                              fontSize: 15),
                        ),
                      ],
                    ),

                    //Some space
                    const SizedBox(height: 10),

                    //Button
                    ElevatedButton.icon(
                      onPressed: () =>
                          canUpload() ? uploadProfileDataFirstTime() : null,
                      icon: const Icon(
                        Icons.person,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Guardar perfil',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),

                    //Some space (bottom)
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Select picture function
  Future selectPicture() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    //If nothing is selected
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    //Can upload checker
    canUpload();
  }

  //Upload profile data
  Future uploadProfileDataFirstTime() async {
    setState(() {
      //Loading circle
      nowLoading = true;
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingCircle();
          });
    });

    //Get user info
    dynamic user = FirebaseAuth.instance.currentUser;
    final String myEmail = user.email;

    //If picked a picture
    if (pickedFile != null) {
      //Define path, file, and reference for picture
      final path =
          'users/${myEmail.replaceAll('.', '')}/profilePicture/picture.${pickedFile!.extension}';
      final file = File(pickedFile!.path!);
      final reference = FirebaseStorage.instance.ref().child(path);

      //Upload process
      try {
        //Upload image to store
        await reference.putFile(file);

        //Upload name, lastname, profession and description
        final ref = FirebaseDatabase.instance
            .ref()
            .child('users/${myEmail.replaceAll('.', '')}');

        ref.set(UserOperations().createUser(
            false, myEmail, name, lastName, profession, description));
      }
      //If there is an exception
      on FirebaseException {
        setState(() {
          //Remove loading circle
          if (context.mounted) {
            Navigator.pop(context);
            //Disable absorb touch
            nowLoading = false;
          }
        });
      }
    }
    //If didn't pick picture but, name, lastname and profession is filled.
    else if (pickedFile == null) {}
    setState(() {
      //Remove loading circle
      if (context.mounted) {
        Navigator.pop(context);
        //Disable absorb touch
        nowLoading = false;
      }
    });
  }

  //Save profile button avaliability checker
  bool canUpload() {
    //If fields are filled
    if (name != '' && lastName != '' && profession != '') {
      debugPrint('YES, YOU CAN UPOLOAD DATA');
      return true;
    }
    //If required fields are incomplete
    else {
      debugPrint('NO, YOU CANNOT UPOLOAD DATA');
      return false;
    }
  }
}
