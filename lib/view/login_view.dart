import 'package:flutter/material.dart';
import 'package:game_app/controller/user_controller.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/subject_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (username.isNotEmpty && password.isNotEmpty) {
                  final user = await _userController.loginUser(username, password);

                  if (user != null) {
                    // Inicio de sesión exitoso, almacena el usuario logeado
                    await _storeLoggedInUser(user);

                    // Navega a la pantalla logueada
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SubjectSelectionScreen(user: user)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Credenciales incorrectas'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, completa todos los campos'),
                    ),
                  );
                }
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _storeLoggedInUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', user.id!);
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
    prefs.setString('password', user.password);
    prefs.setString('name', user.name);
  }
}
