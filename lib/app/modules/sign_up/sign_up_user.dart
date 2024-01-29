import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_project/app/modules/sign_in/user_sign_in.dart';
import 'package:monitoring_project/app/modules/user_auth/firebase_auth_services.dart';
import 'package:monitoring_project/app/modules/welcome/views/welcome_view.dart';
import 'package:monitoring_project/app/modules/sign_up/form_container_widget.dart';
import 'package:monitoring_project/app/modules/common/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // If screen width is less than 600 (considered mobile), show image on top
              if (constraints.maxWidth < 600) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Replace with your image asset
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 20),
                    buildFormSection(),
                  ],
                );
              } else {
                // If screen width is 600 or more (considered larger screen), show image on the left
                return Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Replace with your image asset
                      height: 800,
                      width: 800,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: buildFormSection()),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildFormSection() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign Up",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          FormContainerWidget(
            controller: _usernameController,
            hintText: "Username",
            isPasswordField: false,
            
          ),
          SizedBox(height: 10),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
            isPasswordField: false,
          ),
          SizedBox(height: 10),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: _signUp,
            child: Container(
              width: 265,
              height: 68,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: isSigningUp
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeView(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });

    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      showToast(message: "Error in Signing up User");
    }
  }
}
