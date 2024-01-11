import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:game_app/controller/passed_level_controller.dart';
import 'package:game_app/controller/user_controller.dart';
import 'package:game_app/model/passed_level_model.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/game_level_final_screen.dart';
import 'package:game_app/view/game_level_screen.dart';
import 'package:game_app/view/home_view.dart'; // Asegúrate de importar GameLevelScreen

class LoggedInScreen extends StatefulWidget {
  final UserModel user;

  LoggedInScreen({Key? key, required this.user}) : super(key: key);

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  final PassedLevelController passedLevelController = PassedLevelController();
  List<PassedLevelModel> passedLevels = [];

  @override
  void initState() {
    super.initState();
    _getPassedLevels();
  }

  void _getPassedLevels() async {
    List<PassedLevelModel> levels = await passedLevelController.getPassedLevels(widget.user.id!);
    for (var element in levels) {
      print(element.id);
      print(element.level);
      print(element.starsEarned);
      print(element.userId);
      print("------------------");
    }
    setState(() {
      passedLevels = levels;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = UserController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(Icons.account_circle),
            const SizedBox(width: 8),
            Text('Hola, ${widget.user.name}'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text(
            'Test.app',
            style: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Completa los test y cubre la cima',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 50),

          SizedBox(
            height: 300,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                List<String> categories = [
                  '1. Historia',
                  '2. Clasificación',
                  '3. Topologías',
                  '4. Componentes de Red',
                  '5. Nivel Final',
                ];

                List<String> squareImages = [
                  'assets/history.png',
                  'assets/hierarchy.png',
                  'assets/topology.png',
                  'assets/local-area-network.png',
                  'assets/trophy.png',
                ];

                int levelNumber = index + 1;
                bool isLevelUnlocked = _isLevelUnlocked(levelNumber);

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: isLevelUnlocked
                            ? [Colors.blue, Colors.lightBlueAccent]
                            : [Colors.grey, Colors.grey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(squareImages[index]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categories[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        if (isLevelUnlocked)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 73, 162, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                String levelTitle = categories[index]; 
                                if(index < 4){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameLevelScreen(
                                      levelTitle: levelTitle,
                                      levelIndex: index,
                                      user: widget.user,
                                    ),
                                  ),
                                );
                                }else{
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameLevelFinalScreen(
                                      levelTitle: levelTitle,
                                      levelIndex: index,
                                      user: widget.user,
                                    ),
                                  ),
                                );
                                }
                              },
                              child: const Center(
                                child: Text(
                                  'Jugar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 5,
              viewportFraction: 0.8,
              scale: 0.9,
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            '! Diviértete con estos test !',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await userController.logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        },
        child: const Icon(Icons.logout),
      ),
    );
  }

  bool _isLevelUnlocked(int index) {
    if (passedLevels.isEmpty) {
      return index == 1;
    }

    int highestPassedLevel = passedLevels
        .map((level) => level.level)
        .reduce((a, b) => a > b ? a : b);

    if(highestPassedLevel < 5){
      return index <= highestPassedLevel+1;
      
    }else{
      return  index <= highestPassedLevel;
    }
  }
}
