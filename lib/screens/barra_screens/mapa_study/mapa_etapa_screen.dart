import 'package:flutter/material.dart';
import 'package:green_cloud/screens/barra_screens/mapa_study/etapa_detalle_screen.dart';
import 'package:green_cloud/screens/barra_screens/mapa_study/juego_actividad_screen.dart';

class MapaEtapaScreen extends StatelessWidget {
  final int etapaIndex;

  const MapaEtapaScreen({Key? key, required this.etapaIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final etapa = etapasData[etapaIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa - ${etapa.nombre}'),
        backgroundColor: etapa.color,
      ),
      body: Column(
        children: [
          _buildTopStats(etapa),
          Expanded(
            child: _buildSectionsList(context, etapa),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStats(EtapaData etapa) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: etapa.color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Racha
          _buildStatItem(
            icon: Icons.local_fire_department,
            color: Colors.orange,
            value: '5',
            label: 'Racha',
          ),

          // Secciones completadas
          _buildStatItem(
            icon: Icons.task_alt,
            color: etapa.color,
            value: '${etapa.seccionesCompletadas}/${etapa.totalSecciones}',
            label: 'Completadas',
          ),

          // Vidas
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

  Widget _buildSectionsList(BuildContext context, EtapaData etapa) {
    // Crear las secciones para esta etapa
    final List<SectionData> secciones = _getSectionsForEtapa(etapa);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: List.generate(
          secciones.length,
          (index) => _buildSectionItem(context, secciones[index], etapa.color),
        ),
      ),
    );
  }

  Widget _buildSectionItem(
      BuildContext context, SectionData seccion, Color etapaColor) {
    return Column(
      children: [
        // Encabezado de la sección
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: seccion.color.withOpacity(0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                seccion.titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.white),
                onPressed: () {
                  _mostrarDescripcionSeccion(context, seccion);
                },
              ),
            ],
          ),
        ),
        // Contenedor de las actividades
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: seccion.color.withOpacity(0.2),
          child: _buildActividadesButtons(context, seccion, etapaColor),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildActividadesButtons(
      BuildContext context, SectionData seccion, Color etapaColor) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      runSpacing: 15,
      children: List.generate(
        seccion.actividades.length,
        (index) => GestureDetector(
          onTap: () {
            // Solo permitir acceso si es la primera actividad o las anteriores están completadas
            if (index <= seccion.completadas) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JuegoActividadScreen(
                    etapaIndex: etapaIndex,
                    seccionTitulo: seccion.titulo,
                    actividadTitulo: seccion.actividades[index],
                    actividadIndex: index,
                    color: seccion.color,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Completa primero las actividades anteriores',
                    style: TextStyle(color: etapaColor),
                  ),
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: index <= seccion.completadas
                  ? Colors.white
                  : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: [
                if (index <= seccion.completadas)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Center(
              child: index < seccion.completadas
                  ? Icon(
                      Icons.check_circle,
                      color: seccion.color,
                      size: 30,
                    )
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: index <= seccion.completadas
                            ? seccion.color
                            : Colors.grey[600],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDescripcionSeccion(BuildContext context, SectionData seccion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          seccion.titulo,
          style: TextStyle(color: seccion.color, fontWeight: FontWeight.bold),
        ),
        content: Text(seccion.descripcion),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: seccion.color),
            child: const Text('CERRAR'),
          ),
        ],
      ),
    );
  }

  List<SectionData> _getSectionsForEtapa(EtapaData etapa) {
    // En base a la etapa, crear secciones específicas
    switch (etapaIndex) {
      case 0: // Desarrollo Sostenible
        return [
          SectionData(
            titulo: 'Conceptos Básicos',
            color: Colors.red[400]!,
            descripcion:
                'Introducción al desarrollo sostenible y conciencia ambiental.',
            actividades: [
              'Introducción',
              'Conceptos fundamentales',
              'Historia del desarrollo sostenible',
              'Quiz inicial',
              'Ejercicios prácticos',
              'Mini-juego educativo',
            ],
            completadas: 3,
          ),
          SectionData(
            titulo: 'Recursos Naturales',
            color: Colors.orange[400]!,
            descripcion:
                'Uso responsable de los recursos naturales y preservación.',
            actividades: [
              'Tipos de recursos',
              'Renovables vs No renovables',
              'Gestión sostenible',
              'Quiz de reconocimiento',
              'Caso de estudio',
              'Actividad práctica',
            ],
            completadas: 0,
          ),
          SectionData(
            titulo: 'ODS de la ONU',
            color: Colors.blue[400]!,
            descripcion:
                'Objetivos de Desarrollo Sostenible de las Naciones Unidas.',
            actividades: [
              'Introducción a los ODS',
              'Los 17 objetivos',
              'Implementación local',
              'Quiz de conocimiento',
              'Proyecto comunitario',
              'Evaluación final',
            ],
            completadas: 0,
          ),
        ];

      case 1: // Ecosistemas
        return [
          SectionData(
            titulo: 'Biodiversidad',
            color: Colors.green[500]!,
            descripcion:
                'Diversidad biológica y su importancia para el planeta.',
            actividades: [
              'Conceptos básicos',
              'Especies en peligro',
              'Ecosistemas frágiles',
              'Quiz de reconocimiento',
              'Observación de campo',
              'Proyecto de conservación',
            ],
            completadas: 0,
          ),
          SectionData(
            titulo: 'Bosques',
            color: Colors.green[700]!,
            descripcion: 'Importancia de los bosques y la deforestación.',
            actividades: [
              'Tipos de bosques',
              'Servicios ecosistémicos',
              'Deforestación',
              'Quiz forestal',
              'Estudio de caso',
              'Proyecto de reforestación',
            ],
            completadas: 0,
          ),
          SectionData(
            titulo: 'Océanos',
            color: Colors.blue[700]!,
            descripcion: 'Ecosistemas marinos y su conservación.',
            actividades: [
              'Vida marina',
              'Contaminación oceánica',
              'Pesca sostenible',
              'Quiz marítimo',
              'Estudio de impacto',
              'Campaña de limpieza',
            ],
            completadas: 0,
          ),
        ];

      // Definir secciones para las demás etapas de manera similar
      default:
        // Secciones genéricas para otras etapas
        return [
          SectionData(
            titulo: 'Introducción',
            color: Colors.purple[400]!,
            descripcion: 'Conceptos básicos y fundamentos de la etapa.',
            actividades: [
              'Conceptos clave',
              'Historia y evolución',
              'Aplicaciones prácticas',
              'Quiz inicial',
              'Ejercicios guiados',
              'Evaluación',
            ],
            completadas: 0,
          ),
          SectionData(
            titulo: 'Aplicación',
            color: Colors.teal[400]!,
            descripcion: 'Implementación de los conocimientos en casos reales.',
            actividades: [
              'Estudio de casos',
              'Resolución de problemas',
              'Trabajo de campo',
              'Quiz intermedio',
              'Proyecto práctico',
              'Evaluación de resultados',
            ],
            completadas: 0,
          ),
          SectionData(
            titulo: 'Avanzado',
            color: Colors.amber[700]!,
            descripcion: 'Conceptos avanzados y aplicaciones especializadas.',
            actividades: [
              'Temas especiales',
              'Investigación aplicada',
              'Innovación y tendencias',
              'Quiz avanzado',
              'Proyecto final',
              'Evaluación de competencias',
            ],
            completadas: 0,
          ),
        ];
    }
  }
}

class SectionData {
  final String titulo;
  final Color color;
  final String descripcion;
  final List<String> actividades;
  final int completadas;

  SectionData({
    required this.titulo,
    required this.color,
    required this.descripcion,
    required this.actividades,
    required this.completadas,
  });
}
