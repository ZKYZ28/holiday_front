import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:holiday_mobile/data/models/login/login.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/login_bloc.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/validators/email.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../data/providers/authentification_api_provider.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          AuthRepository(RepositoryProvider.of<AuthAPiProvider>(context))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Holiday',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1E3A8A),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // Message d'erreur
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  // TODO SNACKBAR PERSO
                  SnackBar(content: Text("${state.errorMessage}")),
                );
            }
            // if (state.status.isSuccess) {
            //   // Remplace toute la pile de navigation par juste la HomeRoute.
            //   // Comme ça on s'assure qu'il ne revienne pas au login
            //  // context.router.replaceAll([HolidaysRoute()]);
            //
            // }
          },
          child: Center(
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
                      child: const Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            PasswordInput(),
                            LoginButton(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      // Espacement interne du Container
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Divider(
                              thickness: 1,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: GoogleButton(),
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
                              onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email *',
              hintText: 'exemple@gmail.com',
              border: const OutlineInputBorder(),
              errorText: !state.email.isPure && state.email.isNotValid
                  ? state.errorMessage
                  : null,
              errorMaxLines: 2,
            ),
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email: email)),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Mot de passe *',
              hintText: '***********',
              border: const OutlineInputBorder(),
              errorText: !state.password.isPure && state.password.isNotValid
                  ? state.errorMessage
                  : null,
              errorMaxLines: 2,
            ),
            obscureText: true,
            onChanged: (password) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: password)),
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          // child: state.status.isInProgress ?
          // const CircularProgressIndicator() :
          child: ElevatedButton(
            onPressed: () {
              context.read<LoginBloc>().add(const LoginSubmit());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
            ),
            child: const Text("Se connecter"),
          ),
        );
      },
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(top: 20),
            // child: state.status.isInProgress ?
            // const CircularProgressIndicator() :
            child: SignInButton(
                Buttons.googleDark,
                text: 'Se connecter avec Google',
                onPressed: () => context.read<LoginBloc>().add(GoogleLoginSubmit())));
      },
    );
  }
}
