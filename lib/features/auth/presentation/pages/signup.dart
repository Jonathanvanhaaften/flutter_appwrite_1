import 'package:flutter/material.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
                controller: _nameController,
                decoration: InputDecoration(hintText: "name"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "password"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                child: const Text('Create account'),
                onPressed: () async {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  if (name.isEmpty || email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("All fields are required."),
                    ));
                    return;
                  }

                  final created = await Authstate.instance
                      .createAccount(name, email, password);
                  if (created) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Account created, login to continue."),
                    ));
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ));
  }
}
 // Center(
              //   child: ElevatedButton(
              //     child: const Text("Signup"),
              //     onPressed: () {
              //       Authstate state =
              //           Provider.of<Authstate>(context, listen: false);
              //       state.createAccount(
              //           _name.text, _email.text, _password.text);
              //     },
              //   ),
              // )