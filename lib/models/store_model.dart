import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreModel extends ChangeNotifier {
  int _coins = 42;
  final List<PurchasedItem> _purchasedItems = [];

  // Categorías disponibles en la tienda
  final List<String> categories = ['Fondos', 'Macetas', 'Pets', 'Accesorios'];

  // Items disponibles en la tienda por categoría
  final Map<String, List<StoreItem>> availableItems = {
    'Fondos': [
      StoreItem(
          id: 'fondo1',
          name: 'FONDO1',
          price: 35,
          image: 'assets/fondos/fondo1.png'),
      StoreItem(
          id: 'fondo2',
          name: 'FONDO2',
          price: 40,
          image: 'assets/fondos/fondo2.png'),
      StoreItem(
          id: 'fondo3',
          name: 'FONDO3',
          price: 45,
          image: 'assets/fondos/fondo3.png'),
      StoreItem(
          id: 'fondo4',
          name: 'FONDO4',
          price: 50,
          image: 'assets/fondos/fondo4.png'),
      StoreItem(
          id: 'fondo5',
          name: 'FONDO5',
          price: 55,
          image: 'assets/fondos/fondo5.png'),
      StoreItem(
          id: 'fondo6',
          name: 'FONDO6',
          price: 60,
          image: 'assets/fondos/fondo6.png'),
    ],
    'Macetas': [
      StoreItem(
          id: 'maceta1',
          name: 'MACETA1',
          price: 25,
          image: 'assets/macetas/maceta1.png'),
      StoreItem(
          id: 'maceta2',
          name: 'MACETA2',
          price: 30,
          image: 'assets/macetas/maceta2.png'),
      StoreItem(
          id: 'maceta3',
          name: 'MACETA3',
          price: 35,
          image: 'assets/macetas/maceta3.png'),
      StoreItem(
          id: 'maceta4',
          name: 'MACETA4',
          price: 40,
          image: 'assets/macetas/maceta4.png'),
      StoreItem(
          id: 'maceta5',
          name: 'MACETA5',
          price: 45,
          image: 'assets/macetas/maceta5.png'),
      StoreItem(
          id: 'maceta6',
          name: 'MACETA6',
          price: 50,
          image: 'assets/macetas/maceta6.png'),
    ],
    'Pets': [
      StoreItem(
          id: 'pet1', name: 'PET1', price: 50, image: 'assets/pets/pet1.png'),
      StoreItem(
          id: 'pet2', name: 'PET2', price: 55, image: 'assets/pets/pet2.png'),
      StoreItem(
          id: 'pet3', name: 'PET3', price: 60, image: 'assets/pets/pet3.png'),
      StoreItem(
          id: 'pet4', name: 'PET4', price: 65, image: 'assets/pets/pet4.png'),
      StoreItem(
          id: 'pet5', name: 'PET5', price: 70, image: 'assets/pets/pet5.png'),
      StoreItem(
          id: 'pet6', name: 'PET6', price: 75, image: 'assets/pets/pet6.png'),
    ],
    'Accesorios': [
      StoreItem(
          id: 'accesorio1',
          name: 'ACC1',
          price: 15,
          image: 'assets/accesorios/acc1.png'),
      StoreItem(
          id: 'accesorio2',
          name: 'ACC2',
          price: 20,
          image: 'assets/accesorios/acc2.png'),
      StoreItem(
          id: 'accesorio3',
          name: 'ACC3',
          price: 25,
          image: 'assets/accesorios/acc3.png'),
      StoreItem(
          id: 'accesorio4',
          name: 'ACC4',
          price: 30,
          image: 'assets/accesorios/acc4.png'),
      StoreItem(
          id: 'accesorio5',
          name: 'ACC5',
          price: 35,
          image: 'assets/accesorios/acc5.png'),
      StoreItem(
          id: 'accesorio6',
          name: 'ACC6',
          price: 40,
          image: 'assets/accesorios/acc6.png'),
      StoreItem(
          id: 'accesorio7',
          name: 'ACC7',
          price: 45,
          image: 'assets/accesorios/acc7.png'),
      StoreItem(
          id: 'accesorio8',
          name: 'ACC8',
          price: 50,
          image: 'assets/accesorios/acc8.png'),
      StoreItem(
          id: 'accesorio9',
          name: 'ACC9',
          price: 55,
          image: 'assets/accesorios/acc9.png'),
    ],
  };

  StoreModel() {
    loadData();
  }

  // Getters
  int get coins => _coins;
  List<PurchasedItem> get purchasedItems => _purchasedItems;

  // Métodos para obtener compras por categoría
  List<PurchasedItem> getPurchasedItemsByCategory(String category) {
    return _purchasedItems.where((item) => item.category == category).toList();
  }

  // Obtener la cantidad de items comprados por categoría
  String getPurchasedCountByCategory(String category) {
    int purchased =
        _purchasedItems.where((item) => item.category == category).length;
    int total = availableItems[category]?.length ?? 0;
    return '$purchased/$total';
  }

  // Verificar si un ítem ya ha sido comprado
  bool isItemPurchased(String itemId) {
    return _purchasedItems.any((item) => item.itemId == itemId);
  }

  // Añadir monedas al usuario
  void addCoins(int amount) {
    _coins += amount;
    saveData();
    notifyListeners();
  }

  // Comprar un ítem
  bool purchaseItem(StoreItem item, String category) {
    // Verificar si ya está comprado
    if (isItemPurchased(item.id)) {
      return false;
    }

    // Verificar si hay suficientes monedas
    if (_coins < item.price) {
      return false;
    }

    // Realizar la compra
    _coins -= item.price;
    _purchasedItems.add(
      PurchasedItem(
        itemId: item.id,
        category: category,
        purchaseDate: DateTime.now(),
      ),
    );

    saveData();
    notifyListeners();
    return true;
  }

  // Guardar datos en SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Guardar monedas
    await prefs.setInt('coins', _coins);

    // Guardar items comprados
    final List<String> purchasedItemsJson =
        _purchasedItems.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList('purchasedItems', purchasedItemsJson);
  }

  // Cargar datos de SharedPreferences
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Cargar monedas
    _coins = prefs.getInt('coins') ?? 42;

    // Cargar items comprados
    final List<String>? purchasedItemsJson =
        prefs.getStringList('purchasedItems');

    if (purchasedItemsJson != null) {
      _purchasedItems.clear();
      for (String itemJson in purchasedItemsJson) {
        final Map<String, dynamic> itemMap = jsonDecode(itemJson);
        _purchasedItems.add(PurchasedItem.fromJson(itemMap));
      }
    }

    notifyListeners();
  }
}

class StoreItem {
  final String id;
  final String name;
  final int price;
  final String image;

  StoreItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class PurchasedItem {
  final String itemId;
  final String category;
  final DateTime purchaseDate;

  PurchasedItem({
    required this.itemId,
    required this.category,
    required this.purchaseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'category': category,
      'purchaseDate': purchaseDate.toIso8601String(),
    };
  }

  factory PurchasedItem.fromJson(Map<String, dynamic> json) {
    return PurchasedItem(
      itemId: json['itemId'],
      category: json['category'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
    );
  }
}
