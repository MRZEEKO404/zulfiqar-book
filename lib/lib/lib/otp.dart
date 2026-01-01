import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cover_page.dart';

class OtpPage extends StatelessWidget {
  final String verificationId;
  OtpPage({required this.verificationId});

  final otp = TextEditingController();

  void verify(BuildContext context) async {
    final cred = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp.text,
    );
    await FirebaseAuth.instance.signInWithCredential(cred);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => CoverPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("Enter OTP"),
          TextField(controller: otp),
          ElevatedButton(
            onPressed: () => verify(context),
            child: const Text("Verify"),
          )
        ]),
      ),
    );
  }
}
