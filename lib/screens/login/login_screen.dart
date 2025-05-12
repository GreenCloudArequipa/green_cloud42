import "package:flutter/material.dart";
import "package:green_cloud/widgets/BottomNavBar.dart";
import "forgot_password_screen.dart";
import "../../services/auth_service.dart";
import "package:flutter/services.dart";
import "package:flutter/cupertino.dart";
import "package:rive/rive.dart" as rive;
import "package:google_fonts/google_fonts.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "../../widgets/animated_combined_painter.dart";

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para los campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Instancia de AuthService
  final AuthService _authService = AuthService();

  //ANIMACION
  var animationLink = "lib/assets/animations/animated_login_screen.riv";

  rive.SMIInput<bool>? isChecking;
  rive.SMIInput<bool>? isHandsUp;
  rive.SMIInput<bool>? trigSuccess;
  rive.SMIInput<bool>? trigFail;
  rive.SMIInput<double>? numLook;
  late rive.StateMachineController? stateMachineController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 244, 255),
      body: Stack(
        children: [
          AnimatedBackground(targetColor: Color.fromARGB(255, 151, 226, 193)),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Text(
                    "Iniciar Sesión",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 310,
                    child: rive.RiveAnimation.asset(animationLink,
                        fit: BoxFit.fill,
                        stateMachines: ["Login Machine"], onInit: (artBoard) {
                      stateMachineController =
                          rive.StateMachineController.fromArtboard(
                        artBoard,
                        "Login Machine",
                      );
                      if (stateMachineController == null) return;
                      artBoard.addController(stateMachineController!);
                      isChecking =
                          stateMachineController?.findInput("isChecking");
                      isHandsUp =
                          stateMachineController?.findInput("isHandsUp");
                      trigSuccess =
                          stateMachineController?.findInput("trigSuccess");
                      trigFail = stateMachineController?.findInput("trigFail");
                      numLook = stateMachineController?.findInput("numLook");
                    }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 600.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                if (isHandsUp != null) {
                                  isHandsUp!.change(false);
                                }
                                if (isChecking == null) return;
                                isChecking!.change(true);
                                if (numLook != null) {
                                  numLook!.change(value.length.toDouble());
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: const Color(0xFF025810),
                                    fontFamily: "Poppins",
                                    fontSize: 24.0),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 241, 244, 255),
                                labelText: 'Correo Electrónico',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF025810)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF025810)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32.0),
                            TextFormField(
                              onChanged: (value) {
                                if (isChecking != null) {
                                  isChecking!.change(false);
                                }
                                if (isHandsUp == null) return;
                                isHandsUp!.change(true);
                              },
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: const Color(0xFF025810),
                                  fontFamily: "Poppins",
                                  fontSize: 24.0,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 241, 244, 255),
                                labelText: 'Contraseña',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF025810)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF025810)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu contraseña';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const ForgotPasswordScreen()),
                                  );
                                },
                                child: const Text(
                                  "¿Olvidaste tu contraseña?",
                                  style: TextStyle(
                                    color: const Color(0xFF025810),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10.0),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Perform login logic here
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  // Add your authentication logic here
                                  print(
                                      'Logging in: $email with password: $password');
                                  isChecking?.change(false);
                                  isHandsUp?.change(false);
                                  trigFail?.change(false);
                                  trigSuccess?.change(true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar()),
                                  );
                                } else {
                                  isChecking?.change(false);
                                  isHandsUp?.change(false);
                                  trigSuccess?.change(false);
                                  trigFail?.change(true);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 193,
                                    39, 44), // Color de fondo del botón
                                foregroundColor:
                                    Colors.white, // Color del texto
                                minimumSize: const Size(double.infinity, 65),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Bordes redondeados
                                ),
                              ),
                              child: Text(
                                'Iniciar Sesión',
                                style: GoogleFonts.poppins(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),
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
                                      Navigator.pushReplacementNamed(
                                          context, "/home");
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
                                      Navigator.pushReplacementNamed(
                                          context, "/home");
                                    }
                                  },
                                  icon: const Icon(Icons.facebook,
                                      color: Colors.blue),
                                  label: const Text(
                                    "Facebook",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),

                            // Espacio adicional para empujar el contenido hacia abajo
                            const SizedBox(height: 50),

                            // Espacio adicional para más contenido
                          ],
                        ),
                      ),
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
