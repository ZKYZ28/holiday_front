import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/logic/blocs/auth_bloc/auth_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Mon profil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 150,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      hintText: 'exemple@gmail.com',
                      border: OutlineInputBorder(),
                      // errorText: !state.email.isPure && state.email.isNotValid
                      //     ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    onChanged: (email) => (),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nom *',
                      hintText: 'exemple@gmail.com',
                      border: OutlineInputBorder(),
                      // errorText: !state.email.isPure && state.email.isNotValid
                      //     ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    onChanged: (email) => (),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Prenom *',
                      hintText: 'exemple@gmail.com',
                      border: OutlineInputBorder(),
                      // errorText: !state.email.isPure && state.email.isNotValid
                      //     ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    onChanged: (email) => (),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe actuel *',
                      hintText: '***********',
                      border: OutlineInputBorder(),
                      // errorText: !state.password.isPure && state.password.isNotValid ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe *',
                      hintText: '***********',
                      border: OutlineInputBorder(),
                      // errorText: !state.password.isPure && state.password.isNotValid ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmation mot de passe *',
                      hintText: '***********',
                      border: OutlineInputBorder(),
                      // errorText: !state.password.isPure && state.password.isNotValid ? state.errorMessage
                      //     : null,
                      errorMaxLines: 2,
                    ),
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthentificationLogoutRequest());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                    ),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text("Se déconnecter"),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
