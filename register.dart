import 'package:project_management/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 🧾 Main Form Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 180), // space below logo
                          // First Name
                          _buildTextField(
                            controller: _firstnameController,
                            hint: 'First Name',
                          ),
                          const SizedBox(height: 20),

                          // Last Name
                          _buildTextField(
                            controller: _lastnameController,
                            hint: 'Last Name',
                          ),
                          const SizedBox(height: 20),

                          // Email
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email ID',
                          ),
                          const SizedBox(height: 20),

                          // Password
                          _buildTextField(
                            controller: _passwordController,
                            hint: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),

                          // Confirm Password
                          _buildTextField(
                            controller: _confirmpasswordController,
                            hint: 'Confirm Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),

                          // Register Button
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                  'First_name: ${_firstnameController.text}',
                                );
                                print('Last_name: ${_lastnameController.text}');
                                print('Email: ${_emailController.text}');
                                print('Password: ${_passwordController.text}');
                                print(
                                  'Confirm Password: ${_confirmpasswordController.text}',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  231,
                                  185,
                                  20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Already Have an Account? Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already Have an Account? ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Divider
                          Container(
                            width: 250,
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),

                    // 🖼 Logo Positioned Separately
                    Positioned(
                      top: 30, // adjust this value to move logo up/down
                      child: Image.asset(
                        'assets/images/Login.png',
                        height: 140,
                        width: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }
}
