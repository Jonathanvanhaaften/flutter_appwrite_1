// import 'package:flutter/material.dart';
// import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
// import 'package:provider/provider.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile')
//         ,),
//         body: Consumer<Authstate>(
//           builder: (context, state, child){
//             final isLoggedIn = Authstate.instance.isLoggedIn();
//             if(!isLoggedIn) return Container();
//             return ListView(
//               padding: const EdgeInsets.all(16.0),
//               children: <Widget>[
//                 Center(
//                   child:  Text(state.user.name ?? '', style: 
//                   Theme.of(context).textTheme.headline4,),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Center(child: Text(state.user.email),),
//                 const SizedBox(height: 30),
//                 Center(
//                  actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 primary: Colors.white,
//               ),
//               child: const Text("Logout"),
//               onPressed: () async {
//                 final loggedOut = await Authstate.instance.logout();
//                 if (loggedOut) {
//                   Navigator.pushReplacementNamed(context, '/login');
//                 }
//               },
//             ),
//                 )
//               ]
//               )
//               },
//             )
//           },)
//     )
//   }
// }