import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailAuthService {
  // Replace with your real SendGrid API Key or Backend Endpoint token
  static const String _sendgridApiKey = 'SG.ReplaceWithYourRealSendGridApiKey';

  static bool get isConfigured =>
      _sendgridApiKey.isNotEmpty &&
      !_sendgridApiKey.contains('ReplaceWithYourRealSendGridApiKey');

  static String generateOtp() {
    return (100000 + Random().nextInt(900000)).toString();
  }

  static Future<bool> sendOtpEmail(String email, String otp) async {
    final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');

    if (!isConfigured) return false;

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_sendgridApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "personalizations": [
            {
              "to": [{"email": email}],
              "subject": "Arogya-SMC App: Your Verification Code"
            }
          ],
          "from": {
            "email": "verification@arogyasmc.com",
            "name": "Arogya-SMC Security"
          },
          "content": [
            {
              "type": "text/plain",
              "value": "Hello,\n\nYour secure verification code for the Arogya-SMC ASHA Worker App is: $otp\n\nThis code will expire in 5 minutes. Please do not share this code with anyone.\n\nThank you,\nArogya-SMC System"
            }
          ]
        }),
      );

      // SendGrid returns 202 Accepted on success
      return response.statusCode == 202 || response.statusCode == 200;
    } catch (e) {
      return false; // Network error or API fault
    }
  }
}
