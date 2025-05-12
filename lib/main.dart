import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:green_cloud/firebase_options.dart";
import "package:green_cloud/app_theme.dart";
import "package:green_cloud/utils/navigation.dart"; // Asegúrate de que este archivo exista
import "package:green_cloud/widgets/BottomNavBar.dart"; // Asegúrate de que este archivo exista
import "package:green_cloud/screens/onboarding/01_splash_screen.dart";
import "package:provider/provider.dart";
import "package:green_cloud/models/store_model.dart";
import "package:green_cloud/models/achievements_model.dart";
import "package:green_cloud/models/user.dart";

Future<void> main() async {
  // Inicializa Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StoreModel()),
        ChangeNotifierProvider(create: (context) => AchievementsModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Oculta el banner de debug
        title: "Green Cloud", // Título de la aplicación
        theme: AppTheme.lightTheme, // Tema claro
        darkTheme: AppTheme.darkTheme, // Tema oscuro
        // themeMode: ThemeMode.system, // Usa el modo del sistema (claro/oscuro)
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // Localización para Material
          GlobalWidgetsLocalizations.delegate, // Localización para widgets
          GlobalCupertinoLocalizations
              .delegate, // Localización para Cupertino (iOS)
        ],
        supportedLocales: const [
          Locale("en", "US"), // Inglés (Estados Unidos)
          Locale("es", "ES"), // Español (España)
        ],
        initialRoute: SplashScreen.routeName, // Ruta inicial
        onGenerateRoute: RouteGenerator.generateRoute, // Generador de rutas
      ),
    );
  }
}
