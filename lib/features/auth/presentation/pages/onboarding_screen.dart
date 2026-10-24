import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2B133A), Color(0xFF121212)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: [
                    SvgPicture.asset(
                      'assets/images/chat_box.svg',
                      height: 20,
                      color: Colors.white,
                    ),
                    Text(
                      "Chatbox",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 50),
                  child: Text.rich(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      height: 1.06,
                    ),
                    TextSpan(
                      children: [
                        TextSpan(text: 'Connect friends '),
                        TextSpan(
                          text: 'easily & quickly',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 56),
                  child: Text(
                    'Our chat app is the perfect way to stay connected with friends and family.',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 184, 179, 179),
                      letterSpacing: 1,
                      height: 1.8,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Facebook");
                      },
                      child: Container(
                        width: 54,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset('assets/images/facebook.png'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Google");
                      },
                      child: Container(
                        width: 54,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset('assets/images/google.png'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Apple");
                      },
                      child: Container(
                        width: 54,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/images/apple.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OR",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 184, 179, 179),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 28),
                  child: _buildSignupButton(),
                ),
                _buildTextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(18),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => SignupScreen()));
        },
        child: Text(
          'Sign up withn mail',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Existing account? ',
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: 'Log in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
