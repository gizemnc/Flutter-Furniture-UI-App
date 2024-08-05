import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/pages/homepage.dart';

class EmailPasswordSignIn extends StatefulWidget {
  const EmailPasswordSignIn({super.key});

  @override
  State<EmailPasswordSignIn> createState() => _EmailPasswordSignInState();
}

class _EmailPasswordSignInState extends State<EmailPasswordSignIn> {
  bool isSignUp = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
  if (_formKey.currentState?.validate() ?? false) {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    try {
      UserCredential userCredential;

      if (isSignUp) {
        if (password == confirmPassword) {
          userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await userCredential.user?.sendEmailVerification(); // Send verification email

          if (kDebugMode) {
            print("Verification email sent to $email");
          } // Debugging statement

          // Store user data
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'email': email,
          });

          // Notify user to verify email
          _showError('Verification email sent. Please verify your email before signing in.');
        } else {
          _showError('Passwords do not match');
          return;
        }
      } else {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Check email verification status
        if (userCredential.user != null && !userCredential.user!.emailVerified) {
          // Sign out the user if email is not verified
          await FirebaseAuth.instance.signOut();
          _showError('Email not verified. Please verify your email before signing in.');
          return;
        }
      }

      // Assuming you have a UserModel constructor or method to create an instance
      UserModel userModel = UserModel(
        userID: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
      );

      // Navigate to HomePage with the UserModel instance
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: userModel),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'An error occurred');
    }
  }
}



  void _showError(String message) {
  if (!mounted) return; // Check if the widget is still mounted

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/images.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isSignUp ? 'Sign Up' : 'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[300],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (isSignUp) ...[
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.person),
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.person),
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                              if (!emailRegExp.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          if (isSignUp)
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          const SizedBox(height: 10),
                          if (isSignUp)
                            Row(
                              children: [
                                Checkbox(
                                  value: true, // This should be replaced with a separate controller if needed
                                  onChanged: (value) {
                                    // Handle checkbox state change
                                  },
                                ),
                                const Text('I accept the Terms of Use & Privacy Policy'),
                              ],
                            ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _submit,
                              child: Text(isSignUp ? "Sign Up" : "Sign In"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSignUp
                                    ? "Already have an account? "
                                    : "Don't have an account? ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignUp = !isSignUp;
                                  });
                                },
                                child: Text(
                                  isSignUp ? "Sign In" : "Sign Up",
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
