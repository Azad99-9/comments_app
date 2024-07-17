import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final _users;

  FirebaseFirestoreService() {
    _users = _firestore.collection('users');
  }

  Future<bool> createUser(
      {required User? user,
      required String name,
      required String email}) async {
    try {
      await _users.add({
        'name': name,
        'email': email,
      }).then((value) {
        print('Document added with ID: ${value.id}');
      }).catchError((error) {
        print('Failed to add document: $error');
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
