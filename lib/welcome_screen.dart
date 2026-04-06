import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/bgwlcome1.png',
              fit: BoxFit.fill,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, _fadeRoute(const LogInScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, _fadeRoute(const SignUpScreen()));
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}