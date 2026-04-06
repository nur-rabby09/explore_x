import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_page.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isHidden = true;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async{
    setState(() {
      _isLoading = true;
    });

    try{
      await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
    password: _passwordController.text.trim(),
    );

      Navigator.pushAndRemoveUntil(// if ok navigaet to home page
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false,
      );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content : Text("Login Successfull")));
    } on FirebaseAuthException catch (e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text(e.message ?? "Login Successfull")));
    }finally{
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

            Center(
              child: Image.asset('assets/logo.png', width: 220, height: 220),
            ),

            const SizedBox(height: 10),

            const Text(
              "Hey, Welcome Back",
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            TextField(// email textfiekd
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

            const SizedBox(height: 15),


            TextField(// password textfiekd
              controller: _passwordController,
              obscureText: _isHidden,
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
                  icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                  onPressed: () => setState(() => _isHidden = !_isHidden),
                ),
              ),
            ),

            const SizedBox(height: 8),


            Align( // login button
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?", style: TextStyle(color: Colors.grey)),
              ),
            ),

            const SizedBox(height: 15),

            Center(// login buttos
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 57.5),
                  ),
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Log In",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),


            Center(// navigate to sign up page
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                child: const Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.grey)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}