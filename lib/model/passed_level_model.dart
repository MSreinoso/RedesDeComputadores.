class PassedLevelModel {
  final int? id;
  final int userId;
  final int level;
  final int starsEarned; // Nuevo campo para almacenar las estrellas ganadas.

  PassedLevelModel({
    this.id,
    required this.userId,
    required this.level,
    required this.starsEarned,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'level': level,
      'starsEarned': starsEarned,
    };
  }

  factory PassedLevelModel.fromMap(Map<String, dynamic> map) {
    return PassedLevelModel(
      id: map['id'],
      userId: map['userId'],
      level: map['level'],
      starsEarned: map['starsEarned'],
    );
  }
}
