import 'package:flutter/material.dart';

class JuegoActividadScreen extends StatefulWidget {
  final int etapaIndex;
  final String seccionTitulo;
  final String actividadTitulo;
  final int actividadIndex;
  final Color color;

  const JuegoActividadScreen({
    Key? key,
    required this.etapaIndex,
    required this.seccionTitulo,
    required this.actividadTitulo,
    required this.actividadIndex,
    required this.color,
  }) : super(key: key);

  @override
  State<JuegoActividadScreen> createState() => _JuegoActividadScreenState();
}

class _JuegoActividadScreenState extends State<JuegoActividadScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  bool _actividadCompletada = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actividadTitulo),
        backgroundColor: widget.color,
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                  // Marcar como completada si llega a la última página
                  if (page == _getPaginasActividad().length - 1) {
                    _actividadCompletada = true;
                  }
                });
              },
              children: _getPaginasActividad(),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final totalPages = _getPaginasActividad().length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.seccionTitulo} - ${widget.actividadTitulo}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
              Text(
                '${_currentPage + 1}/$totalPages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: ((_currentPage + 1) / totalPages),
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isLastPage = _currentPage == _getPaginasActividad().length - 1;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: widget.color,
                side: BorderSide(color: widget.color),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text('Anterior'),
                ],
              ),
            )
          else
            const SizedBox(width: 120), // Espacio cuando no hay botón anterior

          ElevatedButton(
            onPressed: () {
              if (isLastPage) {
                // Volver a la pantalla anterior al completar
                Navigator.pop(context);
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Text(isLastPage ? 'Completar' : 'Siguiente'),
                const SizedBox(width: 8),
                Icon(isLastPage ? Icons.check : Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Generar páginas de contenido basadas en la actividad actual
  List<Widget> _getPaginasActividad() {
    // Simulamos diferentes tipos de actividades según el índice
    switch (widget.actividadIndex) {
      case 0: // Introducción
        return [
          _buildContenidoTexto(
            'Introducción',
            'Bienvenido a esta actividad de aprendizaje. Aquí aprenderás conceptos importantes sobre sostenibilidad ambiental y cómo aplicarlos en tu vida diaria.',
            Icons.lightbulb_outline,
          ),
          _buildContenidoImagen(
            'Objetivos de Aprendizaje',
            'En esta actividad, aprenderás:\n\n• Conceptos básicos de sostenibilidad\n• Impacto de nuestras acciones en el medio ambiente\n• Prácticas sostenibles para la vida diaria',
            'lib/assets/images/learning.png',
          ),
          _buildContenidoTexto(
            '¡Vamos a comenzar!',
            'Desliza para continuar con la lección y no olvides completar todas las actividades para ganar puntos y desbloquear nuevos contenidos.',
            Icons.play_arrow,
          ),
        ];

      case 1: // Conceptos
        return [
          _buildContenidoTexto(
            'Conceptos Fundamentales',
            'La sostenibilidad se basa en tres pilares principales: ambiental, económico y social. Estos tres aspectos deben estar en equilibrio para lograr un desarrollo verdaderamente sostenible.',
            Icons.science,
          ),
          _buildContenidoImagen(
            'Pilares de la Sostenibilidad',
            '1. Ambiental: Preservación de ecosistemas y recursos naturales\n2. Económico: Desarrollo económico equitativo\n3. Social: Bienestar humano y equidad social',
            'lib/assets/images/sustainability.png',
          ),
          _buildQuiz(
            '¿Cuáles son los tres pilares de la sostenibilidad?',
            [
              'Ambiental, Político, Social',
              'Ambiental, Económico, Social',
              'Ecológico, Financiero, Cultural',
              'Natural, Artificial, Humano'
            ],
            1,
          ),
        ];

      case 2: // Actividad práctica
        return [
          _buildContenidoTexto(
            'Actividad Práctica',
            'Ahora aplicaremos lo aprendido con un ejercicio práctico. Esto te ayudará a comprender mejor los conceptos y a desarrollar habilidades para aplicarlos en situaciones reales.',
            Icons.build,
          ),
          _buildInteractivo(
            'Clasificación de Residuos',
            'Arrastra cada residuo a su contenedor correspondiente:',
          ),
          _buildContenidoTexto(
            '¡Buen trabajo!',
            'Has completado con éxito la actividad práctica. Recuerda aplicar estos conocimientos en tu vida diaria para contribuir a un planeta más sostenible.',
            Icons.check_circle,
          ),
        ];

      default: // Para otras actividades
        return [
          _buildContenidoTexto(
            'Actividad en Desarrollo',
            'Esta actividad está en desarrollo. Pronto tendrás acceso a nuevo contenido educativo sobre sostenibilidad ambiental.',
            Icons.construction,
          ),
          _buildContenidoTexto(
            'Mantente atento',
            'Estamos trabajando para ofrecerte la mejor experiencia de aprendizaje. Mientras tanto, puedes explorar otras secciones disponibles.',
            Icons.hourglass_empty,
          ),
        ];
    }
  }

  // Widgets para diferentes tipos de contenido
  Widget _buildContenidoTexto(String titulo, String contenido, IconData icono) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 60, color: widget.color),
          const SizedBox(height: 20),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            contenido,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContenidoImagen(
      String titulo, String contenido, String imagenPath) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              imagenPath,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: widget.color.withOpacity(0.1),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: widget.color,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            contenido,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuiz(
      String pregunta, List<String> opciones, int respuestaCorrecta) {
    return StatefulBuilder(
      builder: (context, setInnerState) {
        int? seleccionada;
        bool mostrarRespuesta = false;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pregunta,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                opciones.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      if (!mostrarRespuesta) {
                        setInnerState(() {
                          seleccionada = index;
                          mostrarRespuesta = true;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: seleccionada == index
                            ? (index == respuestaCorrecta
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2))
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: seleccionada == index
                              ? (index == respuestaCorrecta
                                  ? Colors.green
                                  : Colors.red)
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              opciones[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: seleccionada == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (mostrarRespuesta && index == respuestaCorrecta)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          if (mostrarRespuesta &&
                              seleccionada == index &&
                              index != respuestaCorrecta)
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (mostrarRespuesta)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    seleccionada == respuestaCorrecta
                        ? '¡Correcto! Muy bien.'
                        : 'Incorrecto. La respuesta correcta es: ${opciones[respuestaCorrecta]}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: seleccionada == respuestaCorrecta
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInteractivo(String titulo, String instrucciones) {
    // Simulación de una actividad interactiva
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            instrucciones,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: widget.color.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.drag_indicator,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Actividad interactiva simulada',
                    style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Aquí iría un componente interactivo real con arrastrar y soltar, juegos, etc.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
