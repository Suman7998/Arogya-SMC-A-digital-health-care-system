import 'package:firebase_auth/firebase_auth.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _api;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepository(this._api);

  Future<AshaWorker?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = cred.user;
      if (user == null) throw Exception('Auth failed');
      await user.reload();
      if (!user.emailVerified) throw Exception('Please verify email first');

      return AshaWorker(
        id: user.uid,
        username: user.email ?? '',
        fullName: user.displayName ?? 'ASHA Worker',
        wardCode: 'SMCC01', // Default
        wardName: 'Solapur',
        phone: user.phoneNumber ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerAndVerify({required String email, required String password, required String fullName}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (cred.user != null) {
      await cred.user!.updateDisplayName(fullName);
      await cred.user!.sendEmailVerification();
    }
  }

  Future<void> signOut() => _auth.signOut();
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
