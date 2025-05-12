import "package:firebase_database/firebase_database.dart";

class FirebaseService {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref("/sensores/0001/real_time");

  Future<Map<String, dynamic>> getSensorData() async {
    final snapshot = await _databaseRef.get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      throw Exception("No data available");
    }
  }
}
