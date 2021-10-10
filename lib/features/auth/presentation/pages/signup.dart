import 'package:flutter/material.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _name = TextEditingController();
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
                "Signup",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _name,
                decoration: InputDecoration(hintText: "name"),
              ),
              const SizedBox(height: 10.0),
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
                  child: const Text("Signup"),
                  onPressed: () {
                    AuthState state =
                        Provider.of<AuthState>(context, listen: false);
                    state.createAccount(
                        _name.text, _email.text, _password.text);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
