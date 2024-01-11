import 'package:flutter/material.dart';
import 'package:game_app/connection/database_provider.dart';
import 'package:game_app/controller/user_controller.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/home_view.dart';
import 'package:game_app/view/login_view.dart';
import 'package:game_app/view/subject_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseProvider().open();

  final UserController userController = UserController();
  final UserModel? loggedInUser = await userController.getLoggedInUser();

  runApp(MyApp(loggedInUser: loggedInUser));
}

class MyApp extends StatelessWidget {
  final UserModel? loggedInUser;

  const MyApp({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget initialScreen = loggedInUser != null
        ? SubjectSelectionScreen(user: loggedInUser!)
        : HomeView();

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => initialScreen,
        '/home': (BuildContext context) => HomeView(),
        '/login': (BuildContext context) => LoginView(),
      },
    );
  }
}
