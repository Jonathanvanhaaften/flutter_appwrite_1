import 'package:flutter_appwrite_1/core/res/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_appwrite_1/features/auth/data/model/user.dart';

// class AuthState extends ChangeNotifier {
//   Client client = Client();
//   late Account _account;
//   late bool _isLoggedIn;
//   late User _user;
//   late String _error;

//   Account get account => _account;
//   bool get isLoggedIn => _isLoggedIn;
//   User get user => _user;
//   String get error => _error;

//   AuthState() {
//     _init();
//   }

//   _init() {
//     _isLoggedIn = false;
//     dynamic _user = null;
//     account = Account(client);
//     client
//         .setEndpoint(AppConstants.endpoint)
//         .setProject(AppConstants.projectId);
//     account = Account(client);
//     _checkIsLoggedIn();
//   }

//   _checkIsLoggedIn() async {
//     try {
//       _user = await _getAccount();
//       _isLoggedIn = true;
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<User> _getAccount() async {
//     try {
//       var res = await account.get();
//       if (res.statusCode == 200) {
//         return User.fromJson(res.data);
//       } else {
//         return true;
//       }
//     } catch (e) {
//       throw e;
//     }
//   }

//   login(String email, String password) async {
//     try {
//       var result =
//           await account.createSession(email: email, password: password);
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }

//   createAccount(String name, String email, String password) async {
//     try {
//       var result =
//           await account.create(email: email, password: password, name: name);
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }
// }

class Authstate {
  late Client client = Client();
  late Account account;

  Authstate._() {
    client = Client()
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    account = Account(client);
  }

  static final Authstate _instance = Authstate._();

  factory Authstate() {
    return _instance;
  }

  static Authstate get instance => _instance;

  // Future<List<Job>> getJobs(BuildContext context) async {
  //   String data =
  //       await DefaultAssetBundle.of(context).loadString('assets/jobs.json');
  //   List<dynamic> json = jsonDecode(data);
  //   List<Job> jobs = json.map((dynamic item) => Job.fromMap(item)).toList();
  //   return jobs;
  // }

  Future<bool> login(String email, String password) async {
    try {
      await account.createSession(email: email, password: password);
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> anonymousLogin() async {
    try {
      await account.createAnonymousSession();
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> createAccount(String name, String email, String password) async {
    try {
      await account.create(name: name, email: email, password: password);
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      await account.get();
      return true;
    } on AppwriteException catch (e) {
      return false;
    }
  }
}
