import 'package:flutter/material.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Count to Quit'),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Text(
                "Login",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: "email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(hintText: "password"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {
                    AuthState state =
                        Provider.of<AuthState>(context, listen: false);
                    state.login(_email.text, _password.text);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
