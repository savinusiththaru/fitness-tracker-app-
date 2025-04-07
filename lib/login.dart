import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 35.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Let\'s Sign You In,',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Let\'s level up your fitness journey.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Color(0xFF909090),
                  ),
                ),
                const SizedBox(height: 28),

                // Email & Password Input Fields
                _buildInputField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 27),
                _buildInputField(
                  label: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color(0xFFB09489),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                // Sign In Button
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 62,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB09489),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                              ),
                            ),
                  ),
                ),

                // Divider
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR Sign in with',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons
                _buildSocialLoginButton(
                  'assets/icons/google.png',
                  'Continue With GOOGLE',
                ),
                const SizedBox(height: 16),
                _buildSocialLoginButton(
                  'assets/icons/facebook.png',
                  'Continue With Facebook',
                ),

                // Footer
                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Don\'t Have An Account? ',
                          style: TextStyle(color: Color(0xFF909090)),
                        ),
                        TextSpan(
                          text: 'SignUp',
                          style: const TextStyle(
                            color: Color(0xFFB09489),
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _authService
          .signInWithEmailAndPassword(email: email, password: password);

      // Only navigate if login was successful
      if (userCredential.user != null) {
        // Show success message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate after a brief delay to show the success message
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false, // Remove all previous routes
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during sign in';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error. Please check your internet connection';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many failed login attempts. Please try again later';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your inbox.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFB09489),
                width: 2.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFB09489),
                width: 2.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFB09489), width: 3),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            hintText: isPassword ? '******************' : '',
            hintStyle: const TextStyle(
              color: Color(0xFF909090),
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF909090),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(String asset, String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x80909090)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          // Social login functionality not implemented as per requirements
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 14, height: 14),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
