import 'package:flutter/material.dart';

class TutorialProfessionalUser extends StatelessWidget {
  const TutorialProfessionalUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff000000), Color(0xff252525)],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              //Welcome text
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 50,
                  right: 0,
                  bottom: 0,
                ),
                child: const Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                    color: Color(0xffffffff),
                  ),
                ),
              ),

              //Some space
              const SizedBox(height: 20),

              //Intro text
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  left: 20,
                  top: MediaQuery.of(context).size.height / 10,
                  right: 20,
                  bottom: 0,
                ),
                child: const Text(
                  """¿Estas listo?\n¡Llegarás a todo el mundo!""",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),

              //Some space
              const SizedBox(height: 40),

              //Tutorial carusell image list
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  physics: const PageScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 50,
                  ),
                  // Direction
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(0),
                    //Cards containers
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 125,
                                color: Color(0xff90caf9),
                              ),

                              //Some space
                              SizedBox(height: 10),

                              Text(
                                'Crea tu perfil profesional\nfacilmente',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.business_center_rounded,
                                size: 125,
                                color: Colors.brown[200],
                              ),

                              //Some space
                              const SizedBox(height: 10),

                              const Text(
                                'Brinda asesoramiento y \natiende consultas',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                                size: 125,
                                color: Colors.green[200],
                              ),

                              //Some space
                              const SizedBox(height: 10),

                              const Text(
                                'Monetizá tu tiempo\nal máximo',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.workspace_premium_rounded,
                                size: 125,
                                color: Colors.orange[200],
                              ),

                              //Some space
                              const SizedBox(height: 10),

                              const Text(
                                'Obtené mas herramientas\ncon un plan de suscripción',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Some space
              SizedBox(height: MediaQuery.of(context).size.height / 10),

              //Start button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createprofilefirsttime');
                },
                child: const Text(
                  'Comenzar',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
