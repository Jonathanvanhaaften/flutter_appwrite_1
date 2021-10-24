import 'package:flutter/material.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter_appwrite_1/features/general/presentation/pages/home.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_appwrite_1/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                controller: _emailController,
                decoration: const InputDecoration(labelText: "email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "password"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter your email and password'),
                    ));
                    return;
                  }
                  final loggedIn =
                      await Authstate.instance.login(email, password);
                  if (loggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
 // child: ElevatedButton(
                //   child: const Text("Login"),
                //   onPressed: () {
                //     Authstate state =
                //         Provider.of<Authstate>(context, listen: false);
                //     state.login(_email.text, _password.text);
                //   },
                // ),