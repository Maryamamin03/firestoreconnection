import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            shadowColor: Colors.blueAccent.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                        shadowColor: Colors.blueAccent.withOpacity(0.5),
                      ),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text.trim(),
                            password: pass.text.trim(),
                          );
                          Navigator.pushReplacementNamed(context, '/allNotes');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
