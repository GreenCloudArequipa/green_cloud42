import "package:flutter/material.dart";
import "../../widgets/animated_combined_painter.dart";
import "package:green_cloud/screens/login/otp_verfication_screen.dart";

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot-password";
  const ForgotPasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(targetColor: Color.fromARGB(255, 151, 226, 193)),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                Text(
                  "¿Olvidaste tu contraseña?",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                    "Ingrese su correo electrónico para recuperar su contraseña",
                    textAlign: TextAlign.center),
                const SizedBox(height: 200),
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
                    labelText: "Correo electrónico",
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OtpVerificationScreen()));
                  },
                  child: Text(
                    "Enviar",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 65),
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: const Color.fromARGB(255, 193, 39, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
