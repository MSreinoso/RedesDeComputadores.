import 'package:flutter/material.dart';
import 'package:game_app/controller/user_controller.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/home_view.dart';
import 'package:game_app/view/logged_in_screen.dart';
import 'package:game_app/view/under_construction_screen.dart';

class SubjectSelectionScreen extends StatelessWidget {
  final UserModel user;

  const SubjectSelectionScreen({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Materia'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSubjectButton(context, 'Matemáticas', Colors.orange),
            const SizedBox(height: 16),
            _buildSubjectButton(context, 'Ciencias', Colors.green),
            const SizedBox(height: 16),
            _buildSubjectButton(context, 'Historia', Colors.blue),
            const SizedBox(height: 16),
            _buildSubjectButton(context, 'Redes de Computadoras', Colors.red),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          UserController userController = UserController();
          await userController.logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
    );
  }

  Widget _buildSubjectButton(
      BuildContext context, String subject, Color color) {
    return ElevatedButton(
      onPressed: () {
        _navigateToSubject(context, user, subject);
      },
      style: ElevatedButton.styleFrom(
        // ignore: deprecated_member_use
        primary: color,
        // ignore: deprecated_member_use
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Text(
          subject,
          style:const  TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _navigateToSubject(
      BuildContext context, UserModel user, String subject) {
    if (subject == 'Redes de Computadoras') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoggedInScreen(user: user)));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => UnderConstructionScreen(user: user)));
    }
  }
}
