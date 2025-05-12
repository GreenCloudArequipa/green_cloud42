import 'package:flutter/material.dart';
import 'package:green_cloud/screens/barra_screens/mapa_study/mapa_etapa_screen.dart';

class EtapaData {
  final String nombre;
  final Color color;
  final String imagen;
  final String descripcion;
  final int totalSecciones;
  final int seccionesCompletadas;
  final List<String> objetivos;

  EtapaData({
    required this.nombre,
    required this.color,
    required this.imagen,
    required this.descripcion,
    required this.totalSecciones,
    required this.seccionesCompletadas,
    required this.objetivos,
  });
}

final List<EtapaData> etapasData = [
  EtapaData(
    nombre: 'Desarrollo Sostenible',
    color: Colors.green,
    imagen: 'lib/assets/images/plant1.png',
    descripcion:
        'Aprende los conceptos fundamentales del desarrollo sostenible y cómo aplicarlos en tu vida diaria.',
    totalSecciones: 10,
    seccionesCompletadas: 3,
    objetivos: [
      'Comprender los principios del desarrollo sostenible',
      'Aplicar prácticas ecológicas en tu día a día',
      'Reducir tu huella ecológica',
      'Promover cambios positivos en tu entorno'
    ],
  ),
  EtapaData(
    nombre: 'Ecosistemas',
    color: Colors.red,
    imagen: 'lib/assets/images/plant2.png',
    descripcion:
        'Descubre cómo funcionan los ecosistemas y la importancia de preservar la biodiversidad.',
    totalSecciones: 8,
    seccionesCompletadas: 0,
    objetivos: [
      'Entender los diferentes tipos de ecosistemas',
      'Reconocer la importancia de cada especie',
      'Identificar amenazas a la biodiversidad',
      'Contribuir a la conservación de hábitats'
    ],
  ),
  EtapaData(
    nombre: 'Energías Renovables',
    color: Colors.blue,
    imagen: 'lib/assets/images/plant3.png',
    descripcion:
        'Explora las diferentes fuentes de energía renovable y su impacto en el medio ambiente.',
    totalSecciones: 7,
    seccionesCompletadas: 0,
    objetivos: [
      'Conocer las diferentes fuentes de energía renovable',
      'Comparar el impacto ambiental de distintas energías',
      'Implementar medidas de ahorro energético',
      'Promover el uso de energías limpias'
    ],
  ),
  EtapaData(
    nombre: 'Economía Circular',
    color: Colors.purple,
    imagen: 'lib/assets/images/plant4.png',
    descripcion:
        'Aprende sobre modelos económicos sostenibles y prácticas de consumo responsable.',
    totalSecciones: 9,
    seccionesCompletadas: 0,
    objetivos: [
      'Entender el concepto de economía circular',
      'Identificar patrones de consumo responsable',
      'Aplicar las 3R: reducir, reutilizar, reciclar',
      'Desarrollar hábitos de consumo consciente'
    ],
  ),
  EtapaData(
    nombre: 'Agua y Recursos Hídricos',
    color: Colors.pink,
    imagen: 'lib/assets/images/plant5.png',
    descripcion:
        'Descubre la importancia del agua y cómo conservar este recurso vital.',
    totalSecciones: 6,
    seccionesCompletadas: 0,
    objetivos: [
      'Comprender el ciclo del agua',
      'Identificar fuentes de contaminación hídrica',
      'Implementar prácticas de ahorro de agua',
      'Contribuir a la preservación de fuentes hídricas'
    ],
  ),
  EtapaData(
    nombre: 'Alimentación Sostenible',
    color: Colors.yellow.shade700,
    imagen: 'lib/assets/images/plant6.png',
    descripcion:
        'Explora cómo nuestras elecciones alimentarias impactan al planeta.',
    totalSecciones: 8,
    seccionesCompletadas: 0,
    objetivos: [
      'Entender el impacto ambiental de la industria alimentaria',
      'Reconocer productos de temporada y locales',
      'Aprender a crear huertos urbanos',
      'Reducir el desperdicio de alimentos'
    ],
  ),
  EtapaData(
    nombre: 'Movilidad Sostenible',
    color: Colors.lime,
    imagen: 'lib/assets/images/plant7.png',
    descripcion:
        'Aprende sobre formas de transporte que respetan el medio ambiente.',
    totalSecciones: 7,
    seccionesCompletadas: 0,
    objetivos: [
      'Conocer alternativas de transporte sostenible',
      'Calcular la huella de carbono del transporte',
      'Planificar rutas eficientes',
      'Promover la movilidad activa'
    ],
  ),
  EtapaData(
    nombre: 'Cambio Climático',
    color: Colors.orange,
    imagen: 'lib/assets/images/plant8.png',
    descripcion:
        'Entiende las causas y consecuencias del cambio climático y qué podemos hacer al respecto.',
    totalSecciones: 10,
    seccionesCompletadas: 0,
    objetivos: [
      'Comprender las causas del cambio climático',
      'Identificar sus impactos globales y locales',
      'Conocer los acuerdos internacionales',
      'Implementar acciones para reducir emisiones'
    ],
  ),
];

class EtapaDetalleScreen extends StatefulWidget {
  final int etapa;

  const EtapaDetalleScreen({Key? key, required this.etapa}) : super(key: key);

  @override
  State<EtapaDetalleScreen> createState() => _EtapaDetalleScreenState();
}

class _EtapaDetalleScreenState extends State<EtapaDetalleScreen> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.etapa - 1;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etapa ${_currentPage + 1}'),
        backgroundColor: etapasData[_currentPage].color,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: etapasData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildEtapaPage(context, etapasData[index], index + 1);
              },
            ),
          ),
          _buildPageIndicator(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEtapaPage(
      BuildContext context, EtapaData etapa, int numeroEtapa) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen de la etapa
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: etapa.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                etapa.imagen,
                width: 150,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.eco,
                    size: 100,
                    color: etapa.color,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Título de la etapa
          Text(
            etapa.nombre,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: etapa.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // Información de secciones
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: etapa.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Secciones: ${etapa.seccionesCompletadas}/${etapa.totalSecciones}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: etapa.color,
              ),
            ),
          ),
          const SizedBox(height: 15),
          // Barra de progreso
          Container(
            width: double.infinity,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: etapa.seccionesCompletadas / etapa.totalSecciones,
              child: Container(
                decoration: BoxDecoration(
                  color: etapa.color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botón Objetivos
              ElevatedButton(
                onPressed: () {
                  _mostrarObjetivos(context, etapa);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: etapa.color,
                  side: BorderSide(color: etapa.color),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'OBJETIVOS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Botón Ingresar
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapaEtapaScreen(etapaIndex: _currentPage),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: etapa.color,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'INGRESAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(etapasData.length, (index) {
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == _currentPage
                  ? etapasData[_currentPage].color
                  : Colors.grey.shade300,
            ),
          );
        }),
      ),
    );
  }

  void _mostrarObjetivos(BuildContext context, EtapaData etapa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Objetivos',
          style: TextStyle(color: etapa.color, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(etapa.descripcion),
              const SizedBox(height: 20),
              ...etapa.objetivos.map((objetivo) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline,
                            color: etapa.color, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(objetivo)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: etapa.color),
            child: const Text('CERRAR'),
          ),
        ],
      ),
    );
  }
}
