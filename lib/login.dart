import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp.dart';

class LoginPage extends StatelessWidget {
  final phone = TextEditingController();

  void sendOtp(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone.text,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      },
      codeSent: (id, _) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OtpPage(verificationId: id)),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ZULFIQAR BOOK",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            TextField(
              controller: phone,
              decoration:
                  const InputDecoration(hintText: "+92XXXXXXXXXX"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendOtp(context),
              child: const Text("Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}
