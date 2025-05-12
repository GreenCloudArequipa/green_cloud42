import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  String _name = 'Enrique Miguel Paco Cusi';
  String _username = 'enriquempc';
  String _email = 'enrique.miguel@ejemplo.com';
  String _password = '********';
  String _profileImage = 'assets/profile.png';
  int _level = 2;
  double _experienceProgress = 0.4; // Progreso entre 0.0 y 1.0
  int _experiencePoints = 240;
  int _experienceToNextLevel = 600;
  bool _notificationsEnabled = true;
  List<Friend> _friends = [];
  List<GlobalUser> _globalUsers = [];

  // Estadísticas
  int _consecutiveDays = 3;
  List<int> _hoursPerDay = [
    2,
    3,
    1,
    4,
    3
  ]; // Horas de uso en los últimos 5 días

  UserModel() {
    _loadData();
    _initializeDemoData();
  }

  // Getters
  String get name => _name;
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get profileImage => _profileImage;
  int get level => _level;
  double get experienceProgress => _experienceProgress;
  int get experiencePoints => _experiencePoints;
  int get experienceToNextLevel => _experienceToNextLevel;
  bool get notificationsEnabled => _notificationsEnabled;
  List<Friend> get friends => _friends;
  List<GlobalUser> get globalUsers => _globalUsers;
  int get consecutiveDays => _consecutiveDays;
  List<int> get hoursPerDay => _hoursPerDay;

  // Setters
  set name(String value) {
    _name = value;
    notifyListeners();
    _saveData();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
    _saveData();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
    _saveData();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
    _saveData();
  }

  set notificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
    _saveData();
  }

  // Método para buscar usuarios
  List<GlobalUser> searchUsers(String query) {
    if (query.isEmpty) {
      return _globalUsers;
    }

    return _globalUsers.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.username.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Método para añadir experiencia
  void addExperience(int points) {
    _experiencePoints += points;

    // Comprobar si subimos de nivel
    if (_experiencePoints >= _experienceToNextLevel) {
      _level++;
      _experiencePoints -= _experienceToNextLevel;
      _experienceToNextLevel =
          (_experienceToNextLevel * 1.5).round(); // Aumentar dificultad
    }

    // Actualizar barra de progreso
    _experienceProgress = _experiencePoints / _experienceToNextLevel;

    notifyListeners();
    _saveData();
  }

  // Método para registrar un día más de uso
  void addConsecutiveDay() {
    _consecutiveDays++;
    notifyListeners();
    _saveData();
  }

  // Método para registrar horas de uso hoy
  void registerHoursToday(int hours) {
    if (_hoursPerDay.length >= 5) {
      _hoursPerDay.removeAt(0);
    }
    _hoursPerDay.add(hours);
    notifyListeners();
    _saveData();
  }

  // Inicializar datos demo
  void _initializeDemoData() {
    // Añadir amigos de ejemplo
    if (_friends.isEmpty) {
      _friends = [
        Friend(
          name: 'Leopoldo Castillo',
          username: 'leopoldoc',
          level: 3,
          experienceProgress: 0.6,
          profileImage: 'assets/friend.png',
          coins: 78,
        ),
        Friend(
          name: 'Ana Gómez',
          username: 'anagomez',
          level: 4,
          experienceProgress: 0.3,
          profileImage: 'assets/friend2.png',
          coins: 120,
        ),
        Friend(
          name: 'Carlos Mendoza',
          username: 'carlosmendoza',
          level: 2,
          experienceProgress: 0.9,
          profileImage: 'assets/friend3.png',
          coins: 65,
        ),
      ];
    }

    // Añadir usuarios globales de ejemplo
    if (_globalUsers.isEmpty) {
      _globalUsers = [
        GlobalUser(
          name: 'Leopoldo Castillo',
          username: 'leopoldoc',
          level: 3,
          experienceProgress: 0.6,
          profileImage: 'assets/friend.png',
          coins: 78,
          isFriend: true,
        ),
        GlobalUser(
          name: 'Ana Gómez',
          username: 'anagomez',
          level: 4,
          experienceProgress: 0.3,
          profileImage: 'assets/friend2.png',
          coins: 120,
          isFriend: true,
        ),
        GlobalUser(
          name: 'Carlos Mendoza',
          username: 'carlosmendoza',
          level: 2,
          experienceProgress: 0.9,
          profileImage: 'assets/friend3.png',
          coins: 65,
          isFriend: true,
        ),
        GlobalUser(
          name: 'Laura Pérez',
          username: 'lauraperez',
          level: 5,
          experienceProgress: 0.7,
          profileImage: 'assets/user1.png',
          coins: 150,
          isFriend: false,
        ),
        GlobalUser(
          name: 'Roberto Santos',
          username: 'robertosantos',
          level: 6,
          experienceProgress: 0.5,
          profileImage: 'assets/user2.png',
          coins: 180,
          isFriend: false,
        ),
        GlobalUser(
          name: 'María López',
          username: 'marialopez',
          level: 4,
          experienceProgress: 0.8,
          profileImage: 'assets/user3.png',
          coins: 110,
          isFriend: false,
        ),
      ];
    }

    notifyListeners();
  }

  // Guardar datos en SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _name);
    await prefs.setString('user_username', _username);
    await prefs.setString('user_email', _email);
    await prefs.setString('user_password', _password);
    await prefs.setString('user_profileImage', _profileImage);
    await prefs.setInt('user_level', _level);
    await prefs.setDouble('user_experienceProgress', _experienceProgress);
    await prefs.setInt('user_experiencePoints', _experiencePoints);
    await prefs.setInt('user_experienceToNextLevel', _experienceToNextLevel);
    await prefs.setBool('user_notificationsEnabled', _notificationsEnabled);
    await prefs.setInt('user_consecutiveDays', _consecutiveDays);
    await prefs.setString('user_hoursPerDay', jsonEncode(_hoursPerDay));

    // Guardar amigos
    final List<String> friendsJson =
        _friends.map((friend) => jsonEncode(friend.toJson())).toList();
    await prefs.setStringList('user_friends', friendsJson);

    // Guardar usuarios globales
    final List<String> globalUsersJson =
        _globalUsers.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList('user_globalUsers', globalUsersJson);
  }

  // Cargar datos desde SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString('user_name') ?? _name;
    _username = prefs.getString('user_username') ?? _username;
    _email = prefs.getString('user_email') ?? _email;
    _password = prefs.getString('user_password') ?? _password;
    _profileImage = prefs.getString('user_profileImage') ?? _profileImage;
    _level = prefs.getInt('user_level') ?? _level;
    _experienceProgress =
        prefs.getDouble('user_experienceProgress') ?? _experienceProgress;
    _experiencePoints =
        prefs.getInt('user_experiencePoints') ?? _experiencePoints;
    _experienceToNextLevel =
        prefs.getInt('user_experienceToNextLevel') ?? _experienceToNextLevel;
    _notificationsEnabled =
        prefs.getBool('user_notificationsEnabled') ?? _notificationsEnabled;
    _consecutiveDays = prefs.getInt('user_consecutiveDays') ?? _consecutiveDays;

    final String? hoursPerDayJson = prefs.getString('user_hoursPerDay');
    if (hoursPerDayJson != null) {
      _hoursPerDay = List<int>.from(jsonDecode(hoursPerDayJson));
    }

    // Cargar amigos
    final List<String>? friendsJson = prefs.getStringList('user_friends');
    if (friendsJson != null && friendsJson.isNotEmpty) {
      _friends =
          friendsJson.map((json) => Friend.fromJson(jsonDecode(json))).toList();
    }

    // Cargar usuarios globales
    final List<String>? globalUsersJson =
        prefs.getStringList('user_globalUsers');
    if (globalUsersJson != null && globalUsersJson.isNotEmpty) {
      _globalUsers = globalUsersJson
          .map((json) => GlobalUser.fromJson(jsonDecode(json)))
          .toList();
    }

    notifyListeners();
  }
}

class Friend {
  final String name;
  final String username;
  final int level;
  final double experienceProgress;
  final String profileImage;
  final int coins;

  Friend({
    required this.name,
    required this.username,
    required this.level,
    required this.experienceProgress,
    required this.profileImage,
    required this.coins,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'level': level,
      'experienceProgress': experienceProgress,
      'profileImage': profileImage,
      'coins': coins,
    };
  }

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      name: json['name'],
      username: json['username'],
      level: json['level'],
      experienceProgress: json['experienceProgress'],
      profileImage: json['profileImage'],
      coins: json['coins'],
    );
  }
}

class GlobalUser {
  final String name;
  final String username;
  final int level;
  final double experienceProgress;
  final String profileImage;
  final int coins;
  final bool isFriend;

  GlobalUser({
    required this.name,
    required this.username,
    required this.level,
    required this.experienceProgress,
    required this.profileImage,
    required this.coins,
    required this.isFriend,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'level': level,
      'experienceProgress': experienceProgress,
      'profileImage': profileImage,
      'coins': coins,
      'isFriend': isFriend,
    };
  }

  factory GlobalUser.fromJson(Map<String, dynamic> json) {
    return GlobalUser(
      name: json['name'],
      username: json['username'],
      level: json['level'],
      experienceProgress: json['experienceProgress'],
      profileImage: json['profileImage'],
      coins: json['coins'],
      isFriend: json['isFriend'],
    );
  }
}
