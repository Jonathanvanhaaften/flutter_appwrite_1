import 'package:flutter_appwrite_1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => AuthState(),
  )
];
