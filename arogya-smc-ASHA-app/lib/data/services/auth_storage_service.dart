import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService {
  static const String _accountsKey = 'registered_accounts';

  // Hashes password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Save account to local storage
  Future<void> saveAccount(Map<String, dynamic> accountData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_accountsKey);
    
    List<dynamic> accounts = [];
    if (jsonString != null) {
      accounts = jsonDecode(jsonString);
    }

    // Remove old registration with same aadhaar if it exists
    accounts.removeWhere((acc) => acc['aadhaarNumber'] == accountData['aadhaarNumber']);
    
    accounts.add(accountData);

    await prefs.setString(_accountsKey, jsonEncode(accounts));
  }

  // Get account by Aadhaar or Mobile Number
  Future<Map<String, dynamic>?> getAccount(String identifier) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_accountsKey);

    if (jsonString != null) {
      final List<dynamic> accounts = jsonDecode(jsonString);
      for (var acc in accounts) {
        if (acc['aadhaarNumber'] == identifier || acc['email'] == identifier || acc['contactNumber'] == identifier) {
          return Map<String, dynamic>.from(acc);
        }
      }
    }
    return null;
  }

  // Verify Credentials
  Future<bool> verifyCredentials(String identifier, String plainPassword) async {
    final account = await getAccount(identifier);
    if (account == null) return false;

    final inputHash = hashPassword(plainPassword);
    return account['passwordHash'] == inputHash;
  }
}
