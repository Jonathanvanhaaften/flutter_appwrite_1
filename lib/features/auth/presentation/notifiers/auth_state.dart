import 'package:flutter_appwrite_1/core/res/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_appwrite_1/features/auth/data/model/darts.dart';
import 'package:appwrite/models.dart';

class Authstate {
  late Client client = Client();
  late Account account;
  late final Database _db;

  Authstate._() {
    client = Client()
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);

    account = Account(client);
    _db = Database(client);
  }

  static final Authstate _instance = Authstate._();

  factory Authstate() {
    return _instance;
  }

  static Authstate get instance => _instance;

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
      debugPrint(e.toString());
      return false;
    }
  }

  Future<User?> getUser() async {
    try {
      return await account.get();
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

//this has been made redundant fuction ment to take the model of SmokedCig in dart.dart to update,add, and create documents
// within the appwrite dattabase
  Future<SmokedCig> addsmoke(
      {required SmokedCig cig,
      required List<String> read,
      required List<String> write}) async {
    final res = await _db.createDocument(
        collectionId: AppConstants.collectionId,
        data: cig.toMap(),
        read: read,
        write: write);
    return SmokedCig.fromMap(res.data);
  }
}
