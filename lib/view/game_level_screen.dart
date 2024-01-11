// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_app/controller/level_resource_controller.dart';
import 'package:game_app/controller/passed_level_controller.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/logged_in_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameLevelScreen extends StatefulWidget {
  final String levelTitle;
  final int levelIndex;
  final UserModel user;

  const GameLevelScreen({
    Key? key,
    required this.levelTitle,
    required this.levelIndex, required this.user,
  }) : super(key: key);

  @override
  _GameLevelScreenState createState() => _GameLevelScreenState();
}

class _GameLevelScreenState extends State<GameLevelScreen> {
  late LevelResources _levelResources;
  int _currentPosition = 0;
  final List<bool> _starColors = List.generate(5, (index) => false);
  YoutubePlayerController? _youtubePlayerController;
  late Question selectedQuestion;
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    _levelResources = _getLevelResources(widget.levelIndex);

    final random = Random();
    final randomQuestionIndex =
        random.nextInt(_levelResources.questions.length);
    selectedQuestion = _levelResources.questions[randomQuestionIndex];

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(_levelResources.videoLink) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false, 
        mute: false, 
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel ${widget.levelTitle}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'Nivel ${widget.levelTitle}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  color: _starColors[i] ? Colors.yellow : Colors.grey[300],
                  size: 30, 
                ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: (_currentPosition + 1) / 14,
            backgroundColor: Colors.grey[300]!,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  Color squareColor = Colors
                      .primaries[index % Colors.primaries.length]
                      .withOpacity(0.6);

                  if (index < 5 ||
                      index % 5 == 0 ||
                      index % 5 == 4 ||
                      index >= 15) {
                    return GestureDetector(
                      onTap: () {
                        _handleSquareTap(index);
                      },
                      child: Card(
                        elevation: 5,
                        color: squareColor,
                        child: Center(
                          child: _buildTileContent(index),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                _handleButtonPress();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    Text(
                      _getButtonTextPass(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getButtonText(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         setState(() {
          //           _currentPosition = (_currentPosition - 1 + 14) % 14;
          //         });
          //       },
          //     ),
          //     const SizedBox(width: 20),
          //     IconButton(
          //       icon: const Icon(Icons.arrow_forward),
          //       onPressed: () {
          //         setState(() {
          //           _currentPosition = (_currentPosition + 1) % 14;
          //         });
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _handleSquareTap(int index) {
    if (index == 0 || index == 4 || index == 7 || index == 11 || index == 13) {
      _handleButtonPress();
    }
  }

  void _handleButtonPress() async {
    if (_currentPosition == 0) {
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: YoutubePlayer(controller: _youtubePlayerController!),
          );
        },
      );
      _updateStarColor(0);
      await _moveToTargetPosition(4);
    } else if (_currentPosition == 4) {
      String sabiasQueInfo = _levelResources.sabiasQue;

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              '¡Sabías que!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                sabiasQueInfo,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _moveToTargetPosition(7);
                },
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.blue,
                  // ignore: deprecated_member_use
                  onPrimary: Colors.white,
                ),
                child: const Text('Continuar'),
              ),
            ],
          );
        },
      );

      sleep(const Duration(milliseconds: 500));
      _updateStarColor(1);
      await _moveToTargetPosition(6);
    } else if (_currentPosition == 7) {
      await showDialog<String>(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedQuestion.questionText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: selectedQuestion.options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              selectedOption = option;
                              Navigator.of(context).pop(option);
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle:const TextStyle(fontSize: 18),
                              minimumSize:const  Size(double.infinity, 50),
                            ),
                            child: Text(option),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); 
                      },
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: Colors.red[800],
                        textStyle: const TextStyle(fontSize: 18),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ),
            );
          });

      if (selectedOption.isNotEmpty) {
        _updateStarColor(2);
        await _moveToTargetPosition(11);
      }
    } else if (_currentPosition == 11) {
      await _handleQuestionReview();
      await _moveToTargetPosition(13);

    } else if (_currentPosition == 13) {
      
      if (_starColors[3]) {
        _updateStarColor(4);
      }
      _showStarsPopup();
    }
  }

  void _updateStarColor(int index) {
    setState(() {
      _starColors[index] = true;
    });
  }

  String _getButtonText() {
    switch (_currentPosition) {
      case 0:
        return 'Videorama';
      case 4:
        return '¿Sabías que?';
      case 7:
        return 'Pregunta del contenido';
      case 11:
        return 'Aprende repasando';
      default:
        return '';
    }
  }

  String _getButtonTextPass() {
    return _currentPosition == 13 ? 'Finalizar' : 'Comenzar';
  }

  Widget _buildTileContent(int index) {
    if (index == 0) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/finishline.png',
            width: 40,
            height: 40,
          ),
          if (_currentPosition == 0)
            Image.asset(
              'assets/avatar.png',
              width: 24,
              height: 24,
            ),
        ],
      );
    } else if (_getVisibleIndex(index) == _currentPosition + 1) {
      return Image.asset(
        'assets/avatar.png',
        width: 24,
        height: 24,
      );
    } else {
      return Text(
        _getVisibleIndex(index).toString(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }
  }

  int _getVisibleIndex(int index) {
    List<int> visibleIndices = [
      1,
      2,
      3,
      4,
      5,
      10,
      15,
      20,
      19,
      18,
      17,
      16,
      11,
      6
    ];
    return visibleIndices.indexOf(index + 1) + 1;
  }

  LevelResources _getLevelResources(int levelIndex) {
    switch (levelIndex) {
      case 0:
        return level1Resources;
      case 1:
        return level2Resources;
      case 2:
        return level3Resources;
      case 3:
        return level4Resources;
      default:
        return level1Resources;
    }
  }

  Future<void> _moveToTargetPosition(int targetPosition) async {
    if (_currentPosition < targetPosition) {
      while (_currentPosition < targetPosition) {
        await Future.delayed(const Duration(
            milliseconds: 500)); 
        setState(() {
          _currentPosition = (_currentPosition + 1) % 14;
        });
      }
    } else if (_currentPosition > targetPosition) {
      // Avanzar en sentido anti-horario
      while (_currentPosition > targetPosition) {
        await Future.delayed(const Duration(
            milliseconds: 500)); 
        setState(() {
          _currentPosition = (_currentPosition - 1 + 14) % 14;
        });
      }
    }
  }

  Future<void> _handleQuestionReview() async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Revisión de la Pregunta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pregunta:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedQuestion.questionText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tu Respuesta:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedOption,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Respuesta Correcta:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedQuestion.options[selectedQuestion.correctOptionIndex],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Explicación:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedQuestion.explanation,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      // ignore: deprecated_member_use
                      primary: Colors.blue,
                      // ignore: deprecated_member_use
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'Cerrar',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  if (selectedOption ==
      selectedQuestion.options[selectedQuestion.correctOptionIndex]) {
    _updateStarColor(3);
  }
}

void _showStarsPopup() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Estrellas obtenidas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < _starColors.length; i++)
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.elasticOut,
                        reverseCurve: Curves.elasticIn,
                      ),
                      child: Icon(
                        Icons.star,
                        color: _starColors[i] ? Colors.amber : Colors.grey[300],
                        size: 40,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _savePassedLevel(); 
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoggedInScreen(user: widget.user,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.blue,
                  // ignore: deprecated_member_use
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _savePassedLevel() async {
  final PassedLevelController passedLevelController = PassedLevelController();
  int totalStarsEarned = _starColors.where((starColor) => starColor).length;
  await passedLevelController.storePassedLevel(
    widget.user.id!,
    widget.levelIndex+1,
    totalStarsEarned,
  );
}




}
