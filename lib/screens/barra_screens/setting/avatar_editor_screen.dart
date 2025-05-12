import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/user.dart';

class AvatarEditorScreen extends StatefulWidget {
  const AvatarEditorScreen({Key? key}) : super(key: key);

  @override
  State<AvatarEditorScreen> createState() => _AvatarEditorScreenState();
}

class _AvatarEditorScreenState extends State<AvatarEditorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Categorías de personalización
  final List<String> _categories = [
    'Cuerpo',
    'Ojos',
    'Cabello',
    'Boca',
    'Ropa',
    'Accesorios'
  ];

  // Opciones simuladas para cada categoría (en una app real, estas vendrían de una base de datos)
  final Map<String, List<String>> _categoryOptions = {
    'Cuerpo': ['cuerpo_1', 'cuerpo_2', 'cuerpo_3', 'cuerpo_4'],
    'Ojos': ['ojos_1', 'ojos_2', 'ojos_3', 'ojos_4'],
    'Cabello': ['cabello_1', 'cabello_2', 'cabello_3', 'cabello_4'],
    'Boca': ['boca_1', 'boca_2', 'boca_3', 'boca_4'],
    'Ropa': ['ropa_1', 'ropa_2', 'ropa_3', 'ropa_4'],
    'Accesorios': ['accesorio_1', 'accesorio_2', 'accesorio_3', 'accesorio_4'],
  };

  // Selecciones actuales (en una app real, estas vendrían del perfil del usuario)
  Map<String, String?> _currentSelections = {
    'Cuerpo': 'cuerpo_1',
    'Ojos': 'ojos_1',
    'Cabello': 'cabello_1',
    'Boca': 'boca_1',
    'Ropa': 'ropa_1',
    'Accesorios': null,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar avatar',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Aquí guardaríamos los cambios del avatar
              // En una app real, actualizaríamos el modelo de usuario
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Avatar guardado correctamente')),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Guardar',
                style: TextStyle(fontSize: 16, color: Colors.blue)),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAvatarPreview(),
          _buildTabBar(),
          _buildTabBarView(),
        ],
      ),
    );
  }

  Widget _buildAvatarPreview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Consumer<UserModel>(
          builder: (context, userModel, child) {
            // En una app real, aquí construiríamos el avatar con las selecciones actuales
            // Por ahora, solo mostramos la imagen actual
            return Stack(
              alignment: Alignment.center,
              children: [
                // Fondo verde claro
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                ),
                // Avatar
                Image.asset(
                  userModel.profileImage,
                  width: 180,
                  height: 180,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.blue,
        tabs: _categories.map((category) => Tab(text: category)).toList(),
      ),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return _buildCategoryOptions(category);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryOptions(String category) {
    final options = _categoryOptions[category] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = _currentSelections[category] == option;

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentSelections[category] = option;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: isSelected
                    ? Border.all(color: Colors.blue, width: 2)
                    : null,
              ),
              child: Center(
                // En una app real, aquí mostraríamos la imagen real del componente
                child: Text(
                  option.split('_')[1],
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
