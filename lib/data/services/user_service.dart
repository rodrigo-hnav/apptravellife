import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptravellife/data/models/user.dart';

class UserService {
  static Future<UserModel?> getUserByEmail(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return UserModel.fromMap(doc.id, doc.data());
    }
    return null;
  }
}
