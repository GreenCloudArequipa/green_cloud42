import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/user.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, userModel, child) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Estadísticas',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue[300],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConsecutiveDaysSection(userModel),
              const SizedBox(height: 24),
              _buildHoursPerDaySection(userModel),
              const SizedBox(height: 24),
              _buildAchievementsSection(userModel),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildConsecutiveDaysSection(UserModel userModel) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Días Seguidos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(7, (index) {
                  // Determinar si el círculo debe estar lleno o vacío
                  final isFilled = index < userModel.consecutiveDays % 7;
                  return _buildDayCircle(index + 1, isFilled);
                }),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${userModel.consecutiveDays} días consecutivos',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCircle(int day, bool isFilled) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? Colors.blue : Colors.grey[200],
            border: Border.all(
              color: isFilled ? Colors.blue : Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isFilled ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _getDayName(day),
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Lun';
      case 2:
        return 'Mar';
      case 3:
        return 'Mié';
      case 4:
        return 'Jue';
      case 5:
        return 'Vie';
      case 6:
        return 'Sáb';
      case 7:
        return 'Dom';
      default:
        return '';
    }
  }

  Widget _buildHoursPerDaySection(UserModel userModel) {
    // Encontrar el valor máximo para escalar el gráfico
    int maxHours = userModel.hoursPerDay.isEmpty
        ? 5
        : userModel.hoursPerDay
            .reduce((curr, next) => curr > next ? curr : next);
    maxHours = maxHours < 5 ? 5 : maxHours;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Horas al Día',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Eje Y
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...List.generate(6, (index) {
                        return Text(
                          '${maxHours - index * (maxHours ~/ 5)}h',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Barras
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(userModel.hoursPerDay.length, (index) {
                          // Calcular altura de la barra
                          final double barHeight =
                              (userModel.hoursPerDay[index] / maxHours) * 150;

                          // Días de la semana, comenzando desde hoy hacia atrás
                          final int daysAgo =
                              userModel.hoursPerDay.length - 1 - index;
                          String dayLabel;

                          if (daysAgo == 0) {
                            dayLabel = 'Hoy';
                          } else if (daysAgo == 1) {
                            dayLabel = 'Ayer';
                          } else {
                            dayLabel = '$daysAgo días';
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 30,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: Colors.pink[300],
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dayLabel,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(UserModel userModel) {
    // En una aplicación real, esto podría mostrar estadísticas de logros
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de Logros',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildAchievementItem(
              'Experiencia Total',
              '${userModel.experiencePoints} puntos',
              Icons.star,
              Colors.amber,
              0.7,
            ),
            const SizedBox(height: 10),
            _buildAchievementItem(
              'Nivel Actual',
              'Nivel ${userModel.level}',
              Icons.trending_up,
              Colors.green,
              userModel.experienceProgress,
            ),
            const SizedBox(height: 10),
            _buildAchievementItem(
              'Uso Semanal',
              '${userModel.hoursPerDay.fold(0, (p, c) => p + c)} horas',
              Icons.timer,
              Colors.blue,
              0.85,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(
    String title,
    String value,
    IconData icon,
    Color color,
    double progress,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: color,
                minHeight: 5,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
