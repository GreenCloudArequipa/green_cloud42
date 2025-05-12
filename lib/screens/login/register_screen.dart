import "package:flutter/material.dart";
import "package:green_cloud/services/auth_service.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "../../widgets/animated_combined_painter.dart";
import "package:green_cloud/screens/login/login_screen.dart";

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register";
  RegisterScreen({Key? key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            AnimatedBackground(
              targetColor: Color.fromARGB(255, 151, 226, 193),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Text(
                    "Crear Cuenta",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Crea una cuenta para que puedas explorar todos los trabajos existentes",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 241, 244, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2.0, // Cambia el grosor del borde aquí
                        ),
                        gapPadding: 11.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: const Color(
                              0xFF025810), // Color del borde cuando el campo está habilitado
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 128,
                              25), // Color del borde cuando el campo está enfocado
                          width: 2.0,
                        ),
                      ),
                      labelText: "Nombre",
                    ),
                  ),
                  const SizedBox(height: 32),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 241, 244, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2.0, // Cambia el grosor del borde aquí
                        ),
                        gapPadding: 11.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: const Color(
                              0xFF025810), // Color del borde cuando el campo está habilitado
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 128,
                              25), // Color del borde cuando el campo está enfocado
                          width: 2.0,
                        ),
                      ),
                      labelText: "Correo",
                    ),
                  ),
                  const SizedBox(height: 32),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 241, 244, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2.0, // Cambia el grosor del borde aquí
                        ),
                        gapPadding: 11.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: const Color(
                              0xFF025810), // Color del borde cuando el campo está habilitado
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 128,
                              25), // Color del borde cuando el campo está enfocado
                          width: 2.0,
                        ),
                      ),
                      labelText: "Contraseña",
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Registrar",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        shadowColor: Colors.white,
                        elevation: 10,
                        backgroundColor: const Color.fromARGB(255, 193, 39, 44),
                      )),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Ya tengo una cuenta",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "O continúa con",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final userCredential =
                              await _authService.signInWithGoogle();
                          if (userCredential != null) {
                            // Navegar a la pantalla principal después del inicio de sesión
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        icon: const FaIcon(FontAwesomeIcons.google,
                            color: Colors.red),
                        label: const Text("Google",
                            style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final userCredential =
                              await _authService.signInWithFacebook();
                          if (userCredential != null) {
                            // Navegar a la pantalla principal después del inicio de sesión
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        label: const Text(
                          "Facebook",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
