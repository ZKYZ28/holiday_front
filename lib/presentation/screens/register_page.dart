import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: const Text(
                  'Inscription',
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
                        margin: const EdgeInsets.only(bottom: 10),
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
                            labelText: 'Nom *',
                            hintText: 'John',
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
                            labelText: 'Prénom *',
                            hintText: 'Doe',
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
                            hintText: '',
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
                            labelText: 'Confirmation mot de passe *',
                            hintText: '',
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
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                          child: const Text("S'enregister"),
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
                      'Vous avez déjà un compte ?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          // Actions pour le bouton S'inscrire
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
