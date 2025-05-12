import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/store_model.dart';
import 'package:green_cloud/models/achievements_model.dart';
import 'package:green_cloud/screens/barra_screens/Rank/medal_detail_screen.dart';
import 'package:green_cloud/screens/barra_screens/Rank/plant_detail_screen.dart';
import 'package:green_cloud/screens/barra_screens/Rank/creature_detail_screen.dart';

class LogrosScreen extends StatefulWidget {
  const LogrosScreen({Key? key}) : super(key: key);

  @override
  State<LogrosScreen> createState() => _LogrosScreenState();
}

class _LogrosScreenState extends State<LogrosScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsModel>(
        builder: (context, achievementsModel, child) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Logros',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.pink[300],
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildStatusCards(context, achievementsModel),
              const SizedBox(height: 20),
              Expanded(
                child: _buildAchievementList(achievementsModel),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildStatusCards(BuildContext context, AchievementsModel model) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _buildAchievementSummaryCard(
            'Medallas',
            model.getMedalsProgress(),
            Icons.emoji_events,
            Colors.pink[100]!,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedallasScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildAchievementSummaryCard(
            'Plantas',
            model.getPlantsProgress(),
            Icons.local_florist,
            Colors.green[100]!,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantasScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildAchievementSummaryCard(
            'Criaturas',
            model.getCreaturesProgress(),
            Icons.pets,
            Colors.orange[100]!,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CriaturasScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementSummaryCard(String title, String progress,
      IconData icon, Color color, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.black54),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(progress, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildAchievementList(AchievementsModel model) {
    // Crear una lista con los últimos 5 logros desbloqueados (en realidad serían los más recientes)
    List<Achievement> recentAchievements = [];

    // Añadir medallas desbloqueadas
    for (String id in model.unlockedMedals) {
      final medal = model.allMedals.firstWhere((m) => m.id == id);
      recentAchievements.add(medal);
    }

    // Añadir plantas desbloqueadas
    for (String id in model.unlockedPlants) {
      final plant = model.allPlants.firstWhere((p) => p.id == id);
      recentAchievements.add(plant);
    }

    // Añadir criaturas desbloqueadas
    for (String id in model.unlockedCreatures) {
      final creature = model.allCreatures.firstWhere((c) => c.id == id);
      recentAchievements.add(creature);
    }

    // Limitar a los 5 más recientes (en un caso real ordenarías por fecha)
    if (recentAchievements.length > 5) {
      recentAchievements = recentAchievements.sublist(0, 5);
    }

    return ListView.builder(
      itemCount: recentAchievements.length,
      itemBuilder: (context, index) {
        final achievement = recentAchievements[index];
        Color color;

        // Asignar color según la categoría
        switch (achievement.category) {
          case 'medals':
            color = Colors.pink[100]!;
            break;
          case 'plants':
            color = Colors.green[100]!;
            break;
          case 'creatures':
            color = Colors.orange[100]!;
            break;
          default:
            color = Colors.blue[100]!;
        }

        return _buildRecentAchievementItem(
          achievement.name,
          achievement.description,
          achievement.iconData,
          color,
        );
      },
    );
  }

  Widget _buildRecentAchievementItem(
      String title, String description, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: Colors.black87),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.check_circle, color: Colors.green[400]),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Medallas
class MedallasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Medallas',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.pink[300],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progreso',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: model.getMedalsProgressValue(),
                backgroundColor: Colors.grey[300],
                color: Colors.pink,
                minHeight: 15,
                borderRadius: BorderRadius.circular(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.getMedalsProgress(),
                        style: TextStyle(color: Colors.grey[600])),
                    Text('Nivel 1', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: model.allMedals.length,
                  itemBuilder: (context, index) {
                    final medal = model.allMedals[index];
                    final isUnlocked = model.isMedalUnlocked(medal.id);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MedalDetailScreen(medalId: medal.id),
                          ),
                        );
                      },
                      child: _buildMedal(medal.name, isUnlocked,
                          isUnlocked ? Colors.pink[100]! : Colors.grey[300]!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMedal(String title, bool unlocked, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: unlocked
                ? Icon(Icons.emoji_events, size: 40, color: Colors.amber)
                : Icon(Icons.lock_outline, size: 30, color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: unlocked ? Colors.black87 : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Pantalla de Plantas
class PlantasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Plantas',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green[300],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progreso',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: model.getPlantsProgressValue(),
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 15,
                borderRadius: BorderRadius.circular(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.getPlantsProgress(),
                        style: TextStyle(color: Colors.grey[600])),
                    Text('Avanzado', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: model.allPlants.length,
                  itemBuilder: (context, index) {
                    final plant = model.allPlants[index];
                    final isUnlocked = model.isPlantUnlocked(plant.id);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlantDetailScreen(plantId: plant.id),
                          ),
                        );
                      },
                      child: _buildPlantItem(
                          plant.name,
                          plant.description.split(':')[0],
                          isUnlocked,
                          isUnlocked ? Colors.green[100]! : Colors.grey[300]!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPlantItem(
      String title, String type, bool unlocked, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.eco,
                size: 30,
                color: unlocked ? Colors.green[800] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: unlocked ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 14,
                      color: unlocked ? Colors.grey[700] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            unlocked
                ? Icon(Icons.check_circle, color: Colors.green[800])
                : Icon(Icons.lock_outline, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Criaturas
class CriaturasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Criaturas',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.orange[300],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progreso',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: model.getCreaturesProgressValue(),
                backgroundColor: Colors.grey[300],
                color: Colors.orange,
                minHeight: 15,
                borderRadius: BorderRadius.circular(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.getCreaturesProgress(),
                        style: TextStyle(color: Colors.grey[600])),
                    Text('Novato', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: model.allCreatures.length,
                  itemBuilder: (context, index) {
                    final creature = model.allCreatures[index];
                    final isUnlocked = model.isCreatureUnlocked(creature.id);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreatureDetailScreen(creatureId: creature.id),
                          ),
                        );
                      },
                      child: _buildCriaturaItem(creature.name, isUnlocked,
                          isUnlocked ? creature.imagePath ?? '' : ''),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCriaturaItem(String name, bool unlocked, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: unlocked ? Colors.orange[100] : Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            unlocked
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.pets,
                            size: 50,
                            color: Colors.orange[300],
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 50,
                      color: Colors.grey[500],
                    ),
                  ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: unlocked ? Colors.black87 : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (unlocked)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 15, color: Colors.amber),
                  Icon(Icons.star, size: 15, color: Colors.amber),
                  Icon(Icons.star, size: 15, color: Colors.grey[400]),
                  Icon(Icons.star, size: 15, color: Colors.grey[400]),
                  Icon(Icons.star, size: 15, color: Colors.grey[400]),
                ],
              )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LogrosScreen(),
  ));
}
