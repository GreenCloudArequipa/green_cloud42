import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/achievements_model.dart';

class PlantDetailScreen extends StatelessWidget {
  final String plantId;

  const PlantDetailScreen({Key? key, required this.plantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsModel>(builder: (context, model, child) {
      // Obtener la planta seleccionada
      final plant = model.allPlants.firstWhere((p) => p.id == plantId);
      final isUnlocked = model.isPlantUnlocked(plantId);

      // Extraer tipo y descripción para mostrarlos por separado
      final parts = plant.description.split(':');
      final plantType = parts[0];
      final plantDescription = parts.length > 1 ? parts[1].trim() : '';

      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(plant.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green[300],
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Parte superior con la imagen de la planta
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.green[50],
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isUnlocked
                            ? Icon(Icons.eco,
                                size: 80, color: Colors.green[800])
                            : Icon(Icons.lock_outline,
                                size: 60, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Parte inferior con descripción y detalles
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Barra de progreso
                    LinearProgressIndicator(
                      value: isUnlocked ? 1.0 : 0.0,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),

                    const SizedBox(height: 20),

                    // Tipo de planta
                    Text(
                      plantType,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    // Descripción
                    Text(
                      plantDescription.isNotEmpty
                          ? plantDescription
                          : 'Planta especial para tu colección.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // Texto adicional
                    Text(
                      isUnlocked
                          ? 'Para completar esta colección, sigue plantando más variedades.'
                          : 'Para desbloquear esta planta, debes cumplir ciertos requisitos.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // Botón de corazón
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red[400],
                          size: 28,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
