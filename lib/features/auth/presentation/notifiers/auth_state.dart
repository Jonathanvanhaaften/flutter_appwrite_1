import 'package:flutter_appwrite_1/core/res/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:appwrite/appwrite.dart';

class AuthState extends ChangeNotifier {
  Client client = Client();
  late Account account;

  AuthState() {
    _init();
  }

  _init() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    account = Account(client);
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    try {
      var res = await account.get();
      print(res);
    } catch (e) {
      print(e);
    }
  }

  login(String email, String password) async {
    try {
      var result =
          await account.createSession(email: email, password: password);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  createAccount(String name, String email, String password) async {
    try {
      var result =
          await account.create(email: email, password: password, name: name);
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
