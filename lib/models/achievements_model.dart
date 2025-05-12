import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementsModel extends ChangeNotifier {
  // Listas para guardar los logros conseguidos
  final List<String> _unlockedMedals = [];
  final List<String> _unlockedPlants = [];
  final List<String> _unlockedCreatures = [];

  // Datos de todas las medallas disponibles
  final List<Achievement> allMedals = [
    Achievement(
      id: 'first_level',
      name: '1er nivel',
      description: 'Alcanza el primer nivel',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'five_plants',
      name: '5 plantas',
      description: 'Cultiva 5 plantas diferentes',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'one_creature',
      name: '1 criatura',
      description: 'Descubre tu primera criatura',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'ten_plants',
      name: '10 plantas',
      description: 'Cultiva 10 plantas diferentes',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'three_creatures',
      name: '3 criaturas',
      description: 'Descubre 3 criaturas diferentes',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'thirty_days',
      name: '30 días',
      description: 'Utiliza la app durante 30 días',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'fifty_plants',
      name: '50 plantas',
      description: 'Cultiva 50 plantas diferentes',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'ten_creatures',
      name: '10 criaturas',
      description: 'Descubre 10 criaturas diferentes',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
    Achievement(
      id: 'hundred_days',
      name: '100 días',
      description: 'Utiliza la app durante 100 días',
      iconData: Icons.emoji_events,
      category: 'medals',
    ),
  ];

  // Datos de todas las plantas disponibles
  final List<Achievement> allPlants = [
    Achievement(
      id: 'first_plant',
      name: 'Primera Planta',
      description: 'Suculenta: Planta fácil de cuidar',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'medicinal_plant',
      name: 'Planta Medicinal',
      description: 'Aloe Vera: Planta con propiedades curativas',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'fruit_plant',
      name: 'Planta Frutal',
      description: 'Fresa: Cultiva tu primera fruta',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'aromatic_plant',
      name: 'Planta Aromática',
      description: 'Lavanda: Planta con aroma relajante',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'ornamental_plant',
      name: 'Planta Ornamental',
      description: 'Rosa: La flor más popular del mundo',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'aquatic_plant',
      name: 'Planta Acuática',
      description: 'Nenúfar: Planta que vive en el agua',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'bonsai_plant',
      name: 'Bonsái',
      description: 'Bonsái: El arte de la miniatura',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'cactus_plant',
      name: 'Cactus',
      description: 'Cactus: Adaptado a ambientes secos',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'shadow_plant',
      name: 'Planta de Sombra',
      description: 'Helecho: Crece bien en lugares con poca luz',
      iconData: Icons.eco,
      category: 'plants',
    ),
    Achievement(
      id: 'climbing_plant',
      name: 'Planta Trepadora',
      description: 'Hiedra: Crece verticalmente sobre superficies',
      iconData: Icons.eco,
      category: 'plants',
    ),
  ];

  // Datos de todas las criaturas disponibles
  final List<Achievement> allCreatures = [
    Achievement(
      id: 'hummingbird',
      name: 'Colibrí',
      description: 'Ave pequeña que se alimenta de néctar',
      iconData: Icons.pets,
      category: 'creatures',
      imagePath: 'assets/criaturas/colibri.png',
    ),
    Achievement(
      id: 'frog',
      name: 'Rana',
      description: 'Anfibio que vive cerca del agua',
      iconData: Icons.pets,
      category: 'creatures',
      imagePath: 'assets/criaturas/rana.png',
    ),
    Achievement(
      id: 'butterfly',
      name: 'Mariposa',
      description: 'Insecto con coloridas alas',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'bee',
      name: 'Abeja',
      description: 'Insecto polinizador esencial',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'beetle',
      name: 'Escarabajo',
      description: 'Insecto con caparazón duro',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'lizard',
      name: 'Lagartija',
      description: 'Reptil de pequeño tamaño',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'snail',
      name: 'Caracol',
      description: 'Molusco de movimiento lento',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'squirrel',
      name: 'Ardilla',
      description: 'Roedor que vive en los árboles',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'owl',
      name: 'Búho',
      description: 'Ave nocturna silenciosa',
      iconData: Icons.pets,
      category: 'creatures',
    ),
    Achievement(
      id: 'fox',
      name: 'Zorro',
      description: 'Mamífero astuto de la familia de los cánidos',
      iconData: Icons.pets,
      category: 'creatures',
    ),
  ];

  AchievementsModel() {
    // Inicializar con algunos logros desbloqueados para demostración
    _unlockedMedals.addAll(['first_level', 'five_plants', 'one_creature']);
    _unlockedPlants.addAll([
      'first_plant',
      'medicinal_plant',
      'fruit_plant',
      'aromatic_plant',
      'ornamental_plant'
    ]);
    _unlockedCreatures.addAll(['hummingbird', 'frog']);

    loadData();
  }

  // Getters para obtener los logros desbloqueados
  List<String> get unlockedMedals => _unlockedMedals;
  List<String> get unlockedPlants => _unlockedPlants;
  List<String> get unlockedCreatures => _unlockedCreatures;

  // Métodos para verificar si un logro está desbloqueado
  bool isMedalUnlocked(String id) {
    return _unlockedMedals.contains(id);
  }

  bool isPlantUnlocked(String id) {
    return _unlockedPlants.contains(id);
  }

  bool isCreatureUnlocked(String id) {
    return _unlockedCreatures.contains(id);
  }

  // Método para desbloquear un logro
  void unlockAchievement(String id, String category) {
    switch (category) {
      case 'medals':
        if (!_unlockedMedals.contains(id)) {
          _unlockedMedals.add(id);
          notifyListeners();
          saveData();
        }
        break;
      case 'plants':
        if (!_unlockedPlants.contains(id)) {
          _unlockedPlants.add(id);
          notifyListeners();
          saveData();
        }
        break;
      case 'creatures':
        if (!_unlockedCreatures.contains(id)) {
          _unlockedCreatures.add(id);
          notifyListeners();
          saveData();
        }
        break;
    }
  }

  // Métodos para obtener información de progreso
  String getMedalsProgress() {
    return '${_unlockedMedals.length}/${allMedals.length}';
  }

  String getPlantsProgress() {
    return '${_unlockedPlants.length}/${allPlants.length}';
  }

  String getCreaturesProgress() {
    return '${_unlockedCreatures.length}/${allCreatures.length}';
  }

  double getMedalsProgressValue() {
    return _unlockedMedals.length / allMedals.length;
  }

  double getPlantsProgressValue() {
    return _unlockedPlants.length / allPlants.length;
  }

  double getCreaturesProgressValue() {
    return _unlockedCreatures.length / allCreatures.length;
  }

  // Guardar datos en SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('unlockedMedals', _unlockedMedals);
    await prefs.setStringList('unlockedPlants', _unlockedPlants);
    await prefs.setStringList('unlockedCreatures', _unlockedCreatures);
  }

  // Cargar datos de SharedPreferences
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final medals = prefs.getStringList('unlockedMedals');
    final plants = prefs.getStringList('unlockedPlants');
    final creatures = prefs.getStringList('unlockedCreatures');

    if (medals != null) {
      _unlockedMedals.clear();
      _unlockedMedals.addAll(medals);
    }

    if (plants != null) {
      _unlockedPlants.clear();
      _unlockedPlants.addAll(plants);
    }

    if (creatures != null) {
      _unlockedCreatures.clear();
      _unlockedCreatures.addAll(creatures);
    }

    notifyListeners();
  }
}

class Achievement {
  final String id;
  final String name;
  final String description;
  final IconData iconData;
  final String category;
  final String? imagePath;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.iconData,
    required this.category,
    this.imagePath,
  });
}
