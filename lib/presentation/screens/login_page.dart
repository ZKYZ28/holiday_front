import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(50),
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email *',
                              hintText: 'exemple@gmail.com',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Le champ ne peut pas être vide";
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Mot de passe *',
                              hintText: 'Description de votre vacance',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Le champ ne peut pas être vide";
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E3A8A),
                            ),
                            child: const Text("Se connecter"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),


                Container(
                  padding: const EdgeInsets.all(10), // Espacement interne du Container
                  child: Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: const Divider(
                          thickness: 1,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),

                      const Text(
                        'Vous n\'avez pas encore de compte ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                          child: const Text("S'inscrire"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
