import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Success Screen'), actions: [
        IconButton(
            onPressed: () => auth
                .signOut()
                .then((value) => Navigator.pushReplacementNamed(context, '/')),
            icon: const Icon(Icons.output_rounded))
      ]),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(height: 200, width: 200, 'assets/success.gif'),
          const Text('Login Successful :)',
              style: TextStyle(fontSize: 30, color: Colors.green))
        ]),
      ),
    );
  }
}
