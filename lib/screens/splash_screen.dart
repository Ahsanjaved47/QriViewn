import 'package:flutter/material.dart';
import 'package:task_1/constants/const.dart';
import 'package:task_1/screens/login_screen.dart';
import 'package:task_1/screens/signup_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          Image.asset('images/image1.png', height: 120,
            cacheWidth: 800,
            cacheHeight: 600,
          ),
          const SizedBox(height: 170),
          ElevatedButton(
            style: KSplashElevatedButtonStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const SignupScreen()),
              );
            },
            child: const Text("SIGN UP", style: KSignUpTextStyle),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const LoginScreen()),
              );
            },
            child: const Text(
              "Already a member? Sign in",
              style: NotAMemberStyle,
            ),
          ),

          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset('images/img.png',
                      fit: BoxFit.cover,
                      cacheWidth: 800,
                      cacheHeight: 600,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.asset('images/img_1.png',
                        fit: BoxFit.cover,
                        cacheWidth: 800,
                        cacheHeight: 600,
                        opacity: const AlwaysStoppedAnimation(0.5)),
                  ),
                  Positioned.fill(
                    child: Image.asset('images/img_2.png',
                        fit: BoxFit.cover,
                        cacheWidth: 800,
                        cacheHeight: 600,
                        opacity: const AlwaysStoppedAnimation(0.7)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}