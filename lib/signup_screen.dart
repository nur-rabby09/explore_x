import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() async{
    if(_passwordController.text.trim() != _confirmPasswordController.text.trim()){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords Do Not Match")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully")),
      );
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(e.message ?? "Sign Up Failed")),
  );
  } finally {
  setState(() {
  _isLoading = false;
  });
  }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 80),

            const Text(
              "Let's Get Started",
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "First Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "User Name",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),


            TextField(
              controller: _passwordController,
              obscureText: _hidePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                  onPressed: () => setState(() => _hidePassword = !_hidePassword),
                ),
              ),
            ),

            const SizedBox(height: 20),


            TextField(
              controller: _confirmPasswordController,
              obscureText: _hideConfirmPassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Confirm Password",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(_hideConfirmPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                  onPressed: () => setState(() => _hideConfirmPassword = !_hideConfirmPassword),
                ),
              ),
            ),

            const SizedBox(height: 35),


            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 57.5),
                ),
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),


            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Log In", style: TextStyle(color: Colors.grey)),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}