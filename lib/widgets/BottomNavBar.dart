import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import 'package:green_cloud/screens/barra_screens/Rank/rank.dart';
import 'package:green_cloud/screens/barra_screens/plant/home_screen.dart';
import 'package:green_cloud/screens/barra_screens/setting/profile_screen.dart';
import 'package:green_cloud/screens/barra_screens/store/store.dart';
import 'package:green_cloud/data/plants_data.dart';
import "package:green_cloud/screens/barra_screens/mapa_study/mapa_de_progreso.dart";

class BottomNavBar extends StatefulWidget {
  static const String routeName = "/bottom_nav_bar";
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;

  final List<NavItem> _navItems = [
    NavItem(
      iconPath: 'lib/assets/icons/flag.svg',
      layerToToggle: 'Vector',
    ),
    NavItem(
      iconPath: 'lib/assets/icons/tent.svg',
      layerToToggle: 'Vector',
    ),
    NavItem(
      iconPath: 'lib/assets/icons/flower.svg',
      layerToToggle: 'Vector',
    ),
    NavItem(
      iconPath: 'lib/assets/icons/plant_stack.svg',
      layerToToggle: 'Vector',
    ),
    NavItem(
      iconPath: 'lib/assets/icons/user.svg',
      layerToToggle: 'Vector',
    ),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    const LogrosScreen(),
    const TiendaScreen(),
    HomeScreens(plant: plants[0]),
    const MapaDeProgreso(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 72, 175, 80),
          unselectedItemColor: Colors.grey,
          items: List.generate(
            _navItems.length,
            (index) {
              final item = _navItems[index];
              return BottomNavigationBarItem(
                icon: CustomSvgIcon(
                  iconPath: item.iconPath,
                  isSelected: _selectedIndex == index,
                  layerToToggle: item.layerToToggle,
                ),
                label: '',
              );
            },
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final String iconPath;
  final String? layerToToggle;

  NavItem({
    required this.iconPath,
    this.layerToToggle,
  });
}

/// Versión StatefulWidget para el ícono SVG, carga el asset solo una vez
class CustomSvgIcon extends StatefulWidget {
  final String iconPath;
  final bool isSelected;
  final String? layerToToggle;

  const CustomSvgIcon({
    super.key,
    required this.iconPath,
    this.isSelected = false,
    this.layerToToggle,
  });

  @override
  _CustomSvgIconState createState() => _CustomSvgIconState();
}

class _CustomSvgIconState extends State<CustomSvgIcon> {
  String? _svgString;
  Color _extractedColor = const Color.fromARGB(255, 187, 209, 179);

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  Future<void> _loadSvg() async {
    final svgStr =
        await DefaultAssetBundle.of(context).loadString(widget.iconPath);
    setState(() {
      _svgString = svgStr;
    });
    _updateSvg();
  }

  void _updateSvg() {
    if (_svgString != null) {
      final document = XmlDocument.parse(_svgString!);

      if (widget.layerToToggle != null) {
        final layerElements = document.findAllElements('*').where(
              (element) => element.getAttribute('id') == widget.layerToToggle,
            );

        for (var layerElement in layerElements) {
          final fillAttribute = layerElement.getAttribute('fill');
          if (fillAttribute != null) {
            try {
              _extractedColor = _parseColor(fillAttribute);
            } catch (_) {
              _extractedColor = const Color.fromARGB(255, 187, 209, 179);
            }
          }
          if (!widget.isSelected) {
            layerElement.setAttribute('display', 'none');
          } else {
            layerElement.removeAttribute('display');
          }
        }
      }
      setState(() {
        _svgString = document.toXmlString();
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomSvgIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      _updateSvg();
    }
  }

  Color _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
    } else if (colorString.startsWith('rgb')) {
      final values = colorString
          .replaceAll(RegExp(r'[^0-9,]'), '')
          .split(',')
          .map((v) => int.parse(v))
          .toList();
      return Color.fromRGBO(values[0], values[1], values[2], 1);
    }
    return const Color.fromARGB(255, 187, 209, 179);
  }

  @override
  Widget build(BuildContext context) {
    if (_svgString == null) {
      return const SizedBox(
        width: 60,
        height: 60,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: widget.isSelected ? _extractedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SvgPicture.string(
          _svgString!,
          width: 65,
          height: 65,
        ),
      ),
    );
  }
}
