import 'package:flutter/material.dart';
import 'package:flutter_appwrite_1/core/res/app_constants.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items = [];
  TextEditingController _nameController = TextEditingController();
  RealtimeSubscription? subscription;
  late final Client client;
  final itemsCollection = AppConstants.collectionId;
  late final Database database;
  late final user;

  @override
  void initState() {
    super.initState();
    client = Client()
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);

    database = Database(client);
    _getUser() async {
      final user = await Authstate.instance.getUser();
      if (user != null) {
        context.read(userProvider).state = user;
      }
    }

    user = _getUser();
    loadItems();
    subscribe();
  }

  int _counter = 0;
  double _cigCost = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
      //Prices of cigarettes is hard coded as (carton = 200 cigs)110.65 as per the price in BC canada on Oct 24 2021
      _cigCost = _counter * .55;
      _updateCig(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _cigCost = _counter * .55;
      _updateCig(_counter);
    });
  }

  loadItems() async {
    try {
      final res = await database.listDocuments(
          collectionId: itemsCollection, limit: 100);
      setState(() {
        items = List<Map<String, dynamic>>.from(res.documents);
      });
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  void subscribe() {
    final realtime = Realtime(client);

    subscription =
        realtime.subscribe(['collections.$itemsCollection.documents']);

    // listen to changes
    subscription!.stream.listen((data) {
      // data will consist of `event` and a `payload`
      if (data.payload.isNotEmpty) {
        switch (data.event) {
          case "database.documents.create":
            var item = data.payload;
            items.add(item);
            setState(() {});
            break;
          case "database.documents.delete":
            var item = data.payload;
            items.removeWhere((it) => it['\$id'] == item['\$id']);
            setState(() {});
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Count to Quit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Smoke count for Today:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(' \$$_cigCost')
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Add a smoke',
          child: const Icon(Icons.add),
          heroTag: null,
        ),
        FloatingActionButton(
          onPressed: _decrementCounter,
          tooltip: 'decrese a smoke',
          child: const Icon(Icons.remove),
          heroTag: null,
        ),
      ]),
    );
  }

// adding of
  void _updateCig(int counter) async {
    try {
      await database.updateDocument(
          collectionId: itemsCollection,
          documentId: '6175e2725169d',
          data: {'cig_tally': counter},
          read: ['*'],
          write: ['*']);
    } on AppwriteException catch (e) {
      debugPrint(e.message);
    }
  }
}
