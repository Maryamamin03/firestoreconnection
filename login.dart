// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'notes_screen.dart';
// import 'signup.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final email = TextEditingController();
//     final pass = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Login',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: email,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: pass,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await FirebaseAuth.instance.signInWithEmailAndPassword(
//                     email: email.text.trim(),
//                     password: pass.text.trim(),
//                   );
//                   Navigator.pushReplacementNamed(context, '/allNotes');
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(e.toString())),
//                   );
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const SignupScreen()),
//                 );
//               },
//               child: const Text('No account? Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: pass.text.trim(),
                        );
                        Navigator.pushReplacementNamed(context, '/allNotes');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text('Don\'t have an account? Sign up'),
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
