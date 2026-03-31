import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Save User
  Future<void> saveUser({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) async {
    await _db.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'phone': phone,
    });
  }

  // 🔹 Save Search History
  Future<void> saveSearchHistory({
    required String userId,
    required String query,
    required String category,
  }) async {
    await _db.collection('history').add({
      'userId': userId,
      'query': query,
      'category': category,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 Get History
  Future<List<Map<String, dynamic>>> getHistory(String userId) async {
    final snapshot = await _db
        .collection('history')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // 🔹 Save Comparison Results
  Future<void> saveComparison({
    required String userId,
    required String category,
    required String query,
    required List results,
  }) async {
    await _db.collection('comparisonResults').add({
      'userId': userId,
      'category': category,
      'query': query,
      'results': results,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
