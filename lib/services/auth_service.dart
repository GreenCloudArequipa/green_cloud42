import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Inicio de sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Error en el inicio de sesión con Google: $e");
      return null;
    }
  }

  // Inicio de sesión con Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );
        return await _auth.signInWithCredential(credential);
      } else {
        print("El inicio de sesión con Facebook falló: ${loginResult.status}");
        return null;
      }
    } catch (e) {
      print("Error en el inicio de sesión con Facebook: $e");
      return null;
    }
  }

  // Inicio de sesión con correo y contraseña
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error en el inicio de sesión con correo y contraseña: $e");
      return null;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut(); // Cerrar sesión en Google
      await FacebookAuth.instance.logOut(); // Cerrar sesión en Facebook
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }

  // Obtener el usuario actual
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
