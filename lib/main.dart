import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_appwrite_1/core/presentation/notifiers/providers.dart';
import 'package:flutter_appwrite_1/core/res/app_constants.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/state.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/pages/login.dart';
import 'package:flutter_appwrite_1/features/auth/presentation/pages/signup.dart';
import 'package:flutter_appwrite_1/features/general/presentation/pages/home.dart';
import 'package:flutter_appwrite_1/features/auth/data/model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
          buttonTheme: ButtonThemeData(
              height: 50.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          primarySwatch: Colors.red),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getUser() async {
      final user = await Authstate.instance.getUser();
      if (user != null) {
        context.read(userProvider).state = user;
      }
    }

    return FutureBuilder<User>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SigninPage();
        if (snapshot.hasData) return HomePage(user: snapshot.data!);
        return LoginPage();
      },
    );
  }
}

// void main() {
//   runApp(ProviderScope(
//     child: MyApp(),
//   ));
// }

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Material App Bar'),
//         ),
//         body: Counter(),
//       ),
//     );
//   }
// }

// class Counter extends StatefulWidget {
//   const Counter({Key? key}) : super(key: key);

//   @override
//   _CounterState createState() => _CounterState();
// }

// class _CounterState extends State<Counter> {
//   late Account account;
//   late Realtime realtime;
//   Client client = Client();
//   void _incrementCounter() async {
//     try {
//       final res = await account.createSession(
//           email: 'user@example.com', password: 'password');
//       print(res);
//       RealtimeSubscription sub = realtime.subscribe(['collections']);
//       print('Got Sub');
//       sub.stream.listen((event) {
//         print(event);
//       });
//       setState(() {});
//     } on AppwriteException catch (e) {
//       print(e.message);
//     }
//   }

//   @override
//   void initState() {
//     client.setEndpoint(AppConstants.endpoint)
//         .setProject(AppConstants.projectId);
// ;
//     realtime = Realtime(client);
//     account = Account(client);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: const Text("Hello"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _incrementCounter,
//       ),
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     _getUser();
//   }

//   _getUser() async {
//     final user = await Authstate.instance.getUser();
//     if (user != null) {
//       context.read(userProvider).state = user;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Chat Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AuthChecker(),
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(builder: (context) {
//           switch (settings.name) {
//             case 'login':
//               return LoginPage();
//             case 'signup':
//               return SigninPage();
//           }
//           //   case 'profile':
//           //     return ProfilePage();
//           //   case 'chat':
//           //   default:
//           //     return ChatPage(
//           //       channel: settings.arguments as Channel,
//           //     );
//           // }
//         });
//       },
//     );
//   }
// }

// class AuthChecker extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final isLoggedIn = watch(userProvider).state != null;
//     return isLoggedIn ? HomePage() : LoginPage();
//   }
// }
