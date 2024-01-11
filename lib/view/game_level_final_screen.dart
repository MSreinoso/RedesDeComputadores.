// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_app/controller/level_resource_controller.dart';
import 'package:game_app/controller/passed_level_controller.dart';
import 'package:game_app/model/user_model.dart';
import 'package:game_app/view/congratulations_screen.dart';

class GameLevelFinalScreen extends StatefulWidget {
  final String levelTitle;
  final int levelIndex;
  final UserModel user;

  const GameLevelFinalScreen({
    Key? key,
    required this.levelTitle,
    required this.levelIndex,
    required this.user,
  }) : super(key: key);

  @override
  _GameLevelScreenState createState() => _GameLevelScreenState();
}

class _GameLevelScreenState extends State<GameLevelFinalScreen> {
  int _currentPosition = 0;
  final List<bool> _starColors = List.generate(5, (index) => false);
  late Question selectedQuestion1;
  String selectedOption1 = '';
  late Question selectedQuestion2;
  String selectedOption2 = '';
  late Question selectedQuestion3;
  String selectedOption3 = '';
  late Question selectedQuestion4;
  String selectedOption4 = '';

  @override
  void initState() {
    super.initState();

    final random = Random();
    final randomQuestionIndex =
        random.nextInt(level1Resources.questions.length);
    selectedQuestion1 = level1Resources.questions[randomQuestionIndex];
    final randomQuestionIndex2 =
        random.nextInt(level2Resources.questions.length);
    selectedQuestion2 = level2Resources.questions[randomQuestionIndex2];
    selectedQuestion3 = level3Resources.questions[randomQuestionIndex];
    selectedQuestion4 = level4Resources.questions[randomQuestionIndex];
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
                  size: 30, // Ajustar el tamaño de las estrellas aquí
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
                      selectedQuestion1.questionText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: selectedQuestion1.options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              selectedOption1 = option;
                              Navigator.of(context).pop(option);
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 18),
                              minimumSize: const Size(double.infinity, 50),
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

      if (selectedOption1.isNotEmpty) {
        if(selectedOption1 == selectedQuestion1.options[selectedQuestion1.correctOptionIndex]){
          _updateStarColor(0);
        }
        await _moveToTargetPosition(4);
      }
    } else if (_currentPosition == 4) {
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
                      selectedQuestion2.questionText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: selectedQuestion2.options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              selectedOption2 = option;
                              Navigator.of(context).pop(option);
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 18),
                              minimumSize: const Size(double.infinity, 50),
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

      if (selectedOption2.isNotEmpty) {
        if(selectedOption2 == selectedQuestion2.options[selectedQuestion2.correctOptionIndex]){
          _updateStarColor(1);
        }
        await _moveToTargetPosition(7);
      }
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
                      selectedQuestion3.questionText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: selectedQuestion3.options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              
                              selectedOption3 = option;
                              Navigator.of(context).pop(option);
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 18),
                              minimumSize: const Size(double.infinity, 50),
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

      if (selectedOption3.isNotEmpty) {
        if(selectedOption3 == selectedQuestion3.options[selectedQuestion3.correctOptionIndex]){
          _updateStarColor(2);
        }
        await _moveToTargetPosition(11);
      }
    } else if (_currentPosition == 11) {
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
                      selectedQuestion4.questionText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: selectedQuestion4.options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              
                              selectedOption4 = option;
                              Navigator.of(context).pop(option);
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 18),
                              minimumSize: const Size(double.infinity, 50),
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

      if (selectedOption4.isNotEmpty) {
       if(selectedOption4 == selectedQuestion4.options[selectedQuestion4.correctOptionIndex]){
          _updateStarColor(3);
        }
        await _moveToTargetPosition(13);
      }
    } else if (_currentPosition == 13) {
      await _handleQuestionReview();

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
        return 'Cuestionario 1';
      case 4:
        return 'Cuestionario 2';
      case 7:
        return 'Cuestionario 3';
      case 11:
        return 'Cuestionario 4';
      default:
        return '';
    }
  }

  String _getButtonTextPass() {
    return _currentPosition == 13 ? 'Aprende Repasando' : 'Comenzar';
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

  Future<void> _moveToTargetPosition(int targetPosition) async {
    if (_currentPosition < targetPosition) {
      // Avanzar en sentido horario
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Revisión de las Preguntas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Pregunta 1:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedQuestion1.questionText,
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
                        selectedOption1,
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
                        selectedQuestion1
                            .options[selectedQuestion1.correctOptionIndex],
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
                        selectedQuestion1.explanation,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Pregunta 2:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedQuestion2.questionText,
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
                        selectedOption2,
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
                        selectedQuestion2
                            .options[selectedQuestion2.correctOptionIndex],
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
                        selectedQuestion2.explanation,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text(
                        'Pregunta 3:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedQuestion3.questionText,
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
                        selectedOption3,
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
                        selectedQuestion3
                            .options[selectedQuestion3.correctOptionIndex],
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
                        selectedQuestion3.explanation,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text(
                        'Pregunta 4:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedQuestion4.questionText,
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
                        selectedOption4,
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
                        selectedQuestion4
                            .options[selectedQuestion4.correctOptionIndex],
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
                        selectedQuestion4.explanation,
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
                            padding: EdgeInsets.symmetric(
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
              ],
            ),
          ),
        );
      },
    );

    if (selectedOption1 ==
        selectedQuestion1.options[selectedQuestion1.correctOptionIndex] && selectedOption2 ==
        selectedQuestion2.options[selectedQuestion2.correctOptionIndex] && selectedOption3 ==
        selectedQuestion3.options[selectedQuestion3.correctOptionIndex] && selectedOption4 ==
        selectedQuestion4.options[selectedQuestion4.correctOptionIndex]) {
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
                          color:
                              _starColors[i] ? Colors.amber : Colors.grey[300],
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
      widget.levelIndex + 1,
      totalStarsEarned,
    );
    if(totalStarsEarned > 3){
      
    Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => CongratulationsScreen(user: widget.user,)),
    );
    }
  }
}
