import 'package:flutter/material.dart';
import '../../../../models/plant.dart';
import '../../../../widgets/sensor_data_row.dart';
import '../../../../widgets/tag_widget.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreens extends StatelessWidget {
  static const String routeName = "/home";
  final Plant plant;
  const HomeScreens({super.key, required this.plant});

  Color _getProgressColor(String type, double value) {
    switch (type) {
      case 'temperature':
        if (value < 20) return Colors.blue;
        if (value < 35) return Colors.green;
        return Colors.red;
      case 'humidity':
      case 'soilMoisture':
        if (value < 30) return Colors.red;
        if (value < 70) return Colors.green;
        return Colors.blue;
      case 'lightLevel':
        if (value < 1000) return Colors.blue;
        if (value < 3000) return Colors.yellow;
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSensorRow(String label, double value, double max, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SensorDataRow(label, "$value"),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / max,
          backgroundColor: Colors.grey.shade300,
          color: _getProgressColor(type, value),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference _databaseRef =
        FirebaseDatabase.instance.ref("sensores/0001/real_time");

    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
        stream: _databaseRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = Map<String, dynamic>.from(
              (snapshot.data!.snapshot.value as Map),
            );
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: plant.backgroundColor,
                    child: Center(
                      child: Image.asset(
                        plant.image,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Robust and dramatic with glossy leaves",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            TagWidget("Easy to grow"),
                            TagWidget("Air cleaner"),
                            TagWidget("Pet friendly"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "SENSORES",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        _buildSensorRow(
                          "Temperatura",
                          data['temperature'] * 1.0,
                          50.0,
                          'temperature',
                        ),
                        _buildSensorRow(
                          "Humedad",
                          data['humidity'] * 1.0,
                          100.0,
                          'humidity',
                        ),
                        _buildSensorRow(
                          "Humedad en Tierra",
                          data['soilMoisture'] * 1.0,
                          100.0,
                          'soilMoisture',
                        ),
                        _buildSensorRow(
                          "Luz",
                          data['lightLevel'] * 1.0,
                          4000.0,
                          'lightLevel',
                        ),
                        SensorDataRow("Tipo de Planta", data['plantType']),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
