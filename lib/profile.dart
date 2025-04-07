import 'package:fitness_test/login.dart';
import 'package:flutter/material.dart';
import 'components/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBEA193)),
        useMaterial3: true,
      ),
      home: ProfileScreen1(),
    );
  }
}

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen1> {
  // Text editing controllers for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController(
    text: "165CM",
  );
  final TextEditingController _weightController = TextEditingController(
    text: "75KG",
  );
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController(
    text: "21Years",
  );
  bool isMale = true;
  bool _isLoading = true;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // First try to get data from Firestore
      Map<String, dynamic>? userData = await _authService.getUserData();

      if (userData != null) {
        setState(() {
          if (userData.containsKey('fullName')) {
            _nameController.text = userData['fullName'];
          }
          if (userData.containsKey('email')) {
            _emailController.text = userData['email'];
          }
          if (userData.containsKey('height')) {
            _heightController.text = userData['height'];
          }
          if (userData.containsKey('weight')) {
            _weightController.text = userData['weight'];
          }
          if (userData.containsKey('age')) {
            _ageController.text = userData['age'];
          }
          if (userData.containsKey('gender')) {
            isMale = userData['gender'] == 'male';
          }
        });
      } else {
        // Fall back to Firebase Auth data
        User? user = _authService.currentUser;
        if (user != null) {
          setState(() {
            if (user.displayName != null && user.displayName!.isNotEmpty) {
              _nameController.text = user.displayName!;
            }
            if (user.email != null && user.email!.isNotEmpty) {
              _emailController.text = user.email!;
            }
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFBEA193)),
                )
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildProfileImage(),
                        const SizedBox(height: 40),
                        _buildNameInputField(),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: _buildUpdatableField(
                                "Height",
                                _heightController,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildUpdatableField(
                                "Weight",
                                _weightController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildUpdatableField("Email", _emailController),
                        const SizedBox(height: 24),
                        _buildGenderSelector(),
                        const SizedBox(height: 24),
                        _buildUpdatableField("Age", _ageController),
                        const SizedBox(height: 40),
                        _buildSaveButton(),
                        const SizedBox(height: 24),
                        _buildSignOutButton(),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/pics/profile.png'),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFBEA193),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: "Enter your name",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(Icons.edit, color: Colors.grey.shade400, size: 18),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildUpdatableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(Icons.edit, color: Colors.grey.shade400, size: 18),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildRadioOption("Male", isMale, () {
                  setState(() => isMale = true);
                }),
              ),
              Expanded(
                child: _buildRadioOption("Female", !isMale, () {
                  setState(() => isMale = false);
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected ? const Color(0xFFBEA193) : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child:
                isSelected
                    ? Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBEA193),
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFFBEA193) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _handleSaveProfile,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFBEA193),
        minimumSize: const Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
      ),
      child: const Text(
        "Save Profile",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return TextButton(
      onPressed: _handleSignOut,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: const Text(
        "Sign Out",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _handleSaveProfile() async {
    // Validate inputs
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name and email')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Update user data in Firestore
      await _authService.updateUserData({
        'fullName': _nameController.text,
        'email': _emailController.text,
        'height': _heightController.text,
        'weight': _weightController.text,
        'age': _ageController.text,
        'gender': isMale ? 'male' : 'female',
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // Update display name in Firebase Auth
      User? user = _authService.currentUser;
      if (user != null) {
        await user.updateDisplayName(_nameController.text);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _authService.signOut();
      // Navigate to login screen after sign out
      if (mounted) {
        Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => LoginPage()),
);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
