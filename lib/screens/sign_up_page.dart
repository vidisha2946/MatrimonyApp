import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Overlay
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/bg.jpg', // Ensure the image path is correct
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.1), // Dark overlay
                ),
              ],
            ),
          ),

          // Sign Up Form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Sign Up Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 12.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Full Name TextField
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Email TextField
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Password TextField
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Sign Up Button
                          ElevatedButton(
                            onPressed: () {
                              // Print a success message to the console
                              print('.......Sign up successfully.......');
                              // Navigate to the dashboard
                              Navigator.pushReplacementNamed(context, '/dashboard');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                              elevation: 5.0,
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Login Button
                          TextButton(
                            onPressed: () {
                              // Go back to the login page
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
