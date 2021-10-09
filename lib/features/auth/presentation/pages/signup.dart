import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
              const TextField(
                decoration: InputDecoration(hintText: "name"),
              ),
              const SizedBox(height: 10.0),
              const TextField(
                decoration: InputDecoration(hintText: "email"),
              ),
              const SizedBox(height: 10.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: "password"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Signup"),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }
}
