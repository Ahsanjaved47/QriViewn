import 'package:flutter/material.dart';
import 'package:task_1/constants/const.dart';
import 'package:task_1/screens/qrcode_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this,  initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset('images/image1.png', height: 120, cacheWidth: 800,
              cacheHeight: 600,),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: const [
                      Tab(text: "Login"),
                      Tab(text: "Sign up"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildLoginTab(),
                        _buildSignupTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: KElevatedButtonStyle,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QrAppScreen())
                );
              },
              child: const Text("LOGIN", style: KLoginTextStyle),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset('images/img.png',
                            fit: BoxFit.cover,
                            cacheWidth: 800,
                            cacheHeight: 600,),
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
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    return Column(
      children: [
        _buildTextField(Icons.person, "User@gmail.com"),
        const SizedBox(height: 10),
        _buildTextField(Icons.lock, "Password", isPassword: true),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerRight,
          child: Text("Forgot Password?", style: KForgetPassStyle),
        ),
      ],
    );
  }

  Widget _buildSignupTab() {
    return Column(
      children: [
        _buildTextField(Icons.person, "Full Name"),
        const SizedBox(height: 10),
        _buildTextField(Icons.email, "Email"),
        const SizedBox(height: 10),
        _buildTextField(Icons.lock, "Password", isPassword: true),
      ],
    );
  }

  Widget _buildTextField(IconData icon, String hintText, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

