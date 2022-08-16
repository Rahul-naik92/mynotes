import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter Email Address'),
            keyboardType: TextInputType.emailAddress,
            controller: _email,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
            controller: _password,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                final userCredinital = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                debugPrint(userCredinital.toString());
              } on FirebaseException catch (e) {
                if (e.code == 'weak-password') {
                  debugPrint('Weak Password');
                } else if (e.code == 'email-already-in-use') {
                  debugPrint('Email already in use');
                } else if (e.code == 'invalid-email') {
                  debugPrint('Invalid Email');
                }
                //debugPrint(e.code);
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!!'),
          ),
        ],
      ),
    );
  }
}
