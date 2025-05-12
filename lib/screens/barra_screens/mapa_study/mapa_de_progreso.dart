import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/store_model.dart';
import 'etapa_detalle_screen.dart';
import 'juegos_seccion_screen.dart';

/// Clase para almacenar la información de cada nivel.
class LevelInfo {
  final Color color; // Color del encabezado
  final String levelName; // Nombre o título del nivel
  final String content; // Contenido del nivel

  LevelInfo({
    required this.color,
    required this.levelName,
    required this.content,
  });
}

class SectionInfo {
  final Color color;
  final String title;
  final String description;
  final List<String> activities;

  SectionInfo({
    required this.color,
    required this.title,
    required this.description,
    required this.activities,
  });
}

class MapaDeProgreso extends StatelessWidget {
  const MapaDeProgreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Progreso'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          _buildTopStats(),
          _buildStageButton(context),
          Expanded(
            child: _buildSectionsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildColoredHeader(BuildContext context, String title, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: color,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildTopStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: Colors.green[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Racha de días consecutivos
          _buildStatItem(
            icon: Icons.local_fire_department,
            color: Colors.orange,
            value: '5',
            label: 'Racha',
          ),

          // Monedas
          Consumer<StoreModel>(
            builder: (context, storeModel, child) {
              return _buildStatItem(
                icon: Icons.monetization_on,
                color: Colors.amber,
                value: '${storeModel.coins}',
                label: 'Monedas',
              );
            },
          ),

          // Corazones
          _buildStatItem(
            icon: Icons.favorite,
            color: Colors.red,
            value: '3',
            label: 'Vidas',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStageButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: Colors.green[100],
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EtapaDetalleScreen(etapa: 1),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'ETAPA 1',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionsList(BuildContext context) {
    // Definir las 10 secciones con sus datos
    final List<SectionInfo> secciones = [
      SectionInfo(
        color: Colors.red[400]!,
        title: 'Sección 1',
        description:
            'Introducción al desarrollo sostenible y conciencia ambiental.',
        activities: [
          'Actividad 1: Introducción',
          'Actividad 2: Conceptos básicos',
          'Actividad 3: Reciclaje básico',
          'Actividad 4: Quiz inicial',
          'Actividad 5: Reto práctico',
          'Actividad 6: Mini-juego',
          'Actividad 7: Evaluación',
        ],
      ),
      SectionInfo(
        color: Colors.orange[400]!,
        title: 'Sección 2',
        description:
            'Residuos y economía circular: reutilización de materiales.',
        activities: [
          'Actividad 1: Tipos de residuos',
          'Actividad 2: Separación correcta',
          'Actividad 3: Economía circular',
          'Actividad 4: Quiz de reconocimiento',
          'Actividad 5: Creación con reciclados',
          'Actividad 6: Mini-juego de clasificación',
          'Actividad 7: Evaluación final',
        ],
      ),
      SectionInfo(
        color: Colors.yellow[700]!,
        title: 'Sección 3',
        description: 'Consumo responsable y huella ecológica personal.',
        activities: [
          'Actividad 1: ¿Qué compramos?',
          'Actividad 2: Huella de carbono',
          'Actividad 3: Consumo local',
          'Actividad 4: Quiz de hábitos',
          'Actividad 5: Reto de reducción',
          'Actividad 6: Mini-juego de compras',
          'Actividad 7: Evaluación y compromisos',
        ],
      ),
      SectionInfo(
        color: Colors.green[500]!,
        title: 'Sección 4',
        description: 'Agua y recursos hídricos: conservación y uso eficiente.',
        activities: [
          'Actividad 1: El ciclo del agua',
          'Actividad 2: Uso doméstico',
          'Actividad 3: Contaminación',
          'Actividad 4: Quiz sobre agua',
          'Actividad 5: Detección de fugas',
          'Actividad 6: Mini-juego de ahorro',
          'Actividad 7: Evaluación práctica',
        ],
      ),
      SectionInfo(
        color: Colors.blue[400]!,
        title: 'Sección 5',
        description: 'Energías renovables y eficiencia energética en el hogar.',
        activities: [
          'Actividad 1: Tipos de energía',
          'Actividad 2: Renovables vs. Fósiles',
          'Actividad 3: Ahorro energético',
          'Actividad 4: Quiz energético',
          'Actividad 5: Auditoría casera',
          'Actividad 6: Mini-juego de fuentes',
          'Actividad 7: Evaluación de impacto',
        ],
      ),
      SectionInfo(
        color: Colors.indigo[400]!,
        title: 'Sección 6',
        description: 'Biodiversidad y ecosistemas: protección y conservación.',
        activities: [
          'Actividad 1: Ecosistemas locales',
          'Actividad 2: Especies en peligro',
          'Actividad 3: Cadenas alimentarias',
          'Actividad 4: Quiz de especies',
          'Actividad 5: Observación natural',
          'Actividad 6: Mini-juego de hábitats',
          'Actividad 7: Evaluación ecosistémica',
        ],
      ),
      SectionInfo(
        color: Colors.purple[400]!,
        title: 'Sección 7',
        description: 'Alimentación sostenible y huertos urbanos.',
        activities: [
          'Actividad 1: Impacto alimentario',
          'Actividad 2: Alimentos de temporada',
          'Actividad 3: Crear un huerto',
          'Actividad 4: Quiz de cultivos',
          'Actividad 5: Recetas sostenibles',
          'Actividad 6: Mini-juego de granjero',
          'Actividad 7: Evaluación de cosecha',
        ],
      ),
      SectionInfo(
        color: Colors.pink[400]!,
        title: 'Sección 8',
        description: 'Movilidad sostenible y reducción de la contaminación.',
        activities: [
          'Actividad 1: Transporte y CO2',
          'Actividad 2: Opciones urbanas',
          'Actividad 3: Planificación de rutas',
          'Actividad 4: Quiz de movilidad',
          'Actividad 5: Reto sin motor',
          'Actividad 6: Mini-juego de tráfico',
          'Actividad 7: Evaluación de impacto',
        ],
      ),
      SectionInfo(
        color: Colors.brown[400]!,
        title: 'Sección 9',
        description: 'Activismo ambiental y participación comunitaria.',
        activities: [
          'Actividad 1: Comunicación verde',
          'Actividad 2: Iniciativas locales',
          'Actividad 3: Diseño de campaña',
          'Actividad 4: Quiz de activismo',
          'Actividad 5: Proyecto grupal',
          'Actividad 6: Mini-juego de influencia',
          'Actividad 7: Evaluación de impacto',
        ],
      ),
      SectionInfo(
        color: Colors.blueGrey[400]!,
        title: 'Sección 10',
        description: 'Cambio climático: causas, efectos y soluciones globales.',
        activities: [
          'Actividad 1: Ciencia climática',
          'Actividad 2: Efectos globales',
          'Actividad 3: Acuerdos internacionales',
          'Actividad 4: Quiz climático',
          'Actividad 5: Plan personal',
          'Actividad 6: Mini-juego de simulación',
          'Actividad 7: Evaluación final',
        ],
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: secciones.length,
      itemBuilder: (context, index) {
        final seccion = secciones[index];
        return _buildSectionItem(context, seccion, index + 1);
      },
    );
  }

  Widget _buildSectionItem(
      BuildContext context, SectionInfo seccion, int numeroSeccion) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: seccion.color.withOpacity(0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sección $numeroSeccion',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.menu_book, color: Colors.white),
                onPressed: () {
                  _showSectionDescription(context, seccion);
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: seccion.color.withOpacity(0.2),
          child: _buildActivityButtons(context, seccion),
        ),
      ],
    );
  }

  Widget _buildActivityButtons(BuildContext context, SectionInfo seccion) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      runSpacing: 15,
      children: List.generate(
        7,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JuegosSeccionScreen(
                  seccionTitle: seccion.title,
                  actividadIndex: index,
                  actividadNombre: seccion.activities[index],
                ),
              ),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: seccion.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSectionDescription(BuildContext context, SectionInfo seccion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(seccion.title),
        content: Text(seccion.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MapaDeProgreso(),
  ));
}
