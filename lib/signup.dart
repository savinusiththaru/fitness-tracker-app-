import 'package:fitness_test/gender.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'services/auth_services.dart';

void main() {
  runApp(const SignupPage());
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup Page',
      theme: ThemeData(
        fontFamily: 'Popover',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB09489)),
      ),
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _isLoading = false;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 89),
            const Text(
              'Create Account!',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              'Signup and start the journey',
              style: TextStyle(fontSize: 15, color: Color(0xFF909090)),
            ),
            const SizedBox(height: 38),
            _buildInputField(
              label: 'Full Name',
              controller: _fullNameController,
            ),
            const SizedBox(height: 27),
            _buildInputField(
              label: 'Email address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 27),
            _buildInputField(
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
              obscureText: _obscureText,
              onToggleVisibility: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB09489),
                  minimumSize: const Size(304, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'SIGN UP',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: Color(0xFF909090)),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSocialButton('GOOGLE', 'assets/icons/google.png', () {}),
                _buildSocialButton(
                  'Facebook',
                  'assets/icons/facebook.png',
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 45),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 13),
                  children: [
                    const TextSpan(
                      text: 'Already Have An Account? ',
                      style: TextStyle(color: Color(0xFF909090)),
                    ),
                    TextSpan(
                      text: 'Login',
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
                                  builder: (context) => LoginPage(),
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
    );
  }

  Future<void> _handleSignUp() async {
    // Validate input fields
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Attempt to sign up the user
      UserCredential userCredential = await _authService
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            fullName: fullName,
          );

      // Success case - user is created
      if (userCredential.user != null) {
        if (!mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to HomePage with a slight delay to allow the message to be seen
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const GenderScreen()),
            (route) => false, // Remove all previous routes
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during sign up';

      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error. Please check your internet connection';
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleVisibility,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? (obscureText ?? true) : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFB09489)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscureText ?? true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xFF909090),
                  ),
                  onPressed: onToggleVisibility,
                )
                : null,
      ),
    );
  }

  Widget _buildSocialButton(
    String text,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 168,
      height: 72,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: const BorderSide(color: Color(0x80909090)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
