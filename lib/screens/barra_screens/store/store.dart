import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/store_model.dart';

class TiendaScreen extends StatefulWidget {
  const TiendaScreen({Key? key}) : super(key: key);

  @override
  State<TiendaScreen> createState() => _TiendaScreenState();
}

class _TiendaScreenState extends State<TiendaScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreModel>(builder: (context, storeModel, child) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.red.shade300,
          title: const Text(
            'Tienda',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                _showMonedasDialog(context, storeModel);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('${storeModel.coins}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.monetization_on,
                        color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: storeModel.categories.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategory(category),
                    _buildGridItems(context, category, storeModel),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCategory(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '...',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItems(
      BuildContext context, String category, StoreModel storeModel) {
    final items = storeModel.availableItems[category] ?? [];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isPurchased = storeModel.isItemPurchased(item.id);

        return GestureDetector(
          onTap: () {
            if (!isPurchased) {
              _showPurchaseDialog(context, item, category, storeModel);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ya has comprado este item'),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isPurchased ? Colors.green : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: isPurchased ? Colors.green[50] : Colors.white,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        item.name.substring(0, 1),
                        style: TextStyle(
                          fontSize: 20,
                          color: isPurchased ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                    if (isPurchased)
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 12,
                  color: isPurchased ? Colors.green : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPurchaseDialog(BuildContext context, StoreItem item,
      String category, StoreModel storeModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(item.name.substring(0, 1),
                        style: const TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${item.price}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _processPurchase(context, item, category, storeModel);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Comprar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  void _showMonedasDialog(BuildContext context, StoreModel storeModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 250,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Monedas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.monetization_on,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${storeModel.coins}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ver',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.videocam,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
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

  void _processPurchase(BuildContext context, StoreItem item, String category,
      StoreModel storeModel) {
    final success = storeModel.purchaseItem(item, category);

    // Cerrar el diálogo de compra
    Navigator.of(context).pop();

    if (success) {
      // Mostrar confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Has comprado ${item.name}!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'No tienes suficientes monedas o ya has comprado este ítem.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: TiendaScreen(),
  ));
}
