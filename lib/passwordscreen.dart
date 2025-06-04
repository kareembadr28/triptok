import 'package:flutter/material.dart';
import 'package:proj/Manage.dart';
import 'package:proj/place.dart';
import 'package:proj/place_screen.dart';
import 'package:proj/signinscreen.dart';
import 'package:proj/user.dart';
import 'package:proj/PlaceSearchScreen.dart';


import 'FirstScreen.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  final String firstname;
  final String lastname;
  const PasswordScreen({
    super.key,
    required this.email,
    required this.firstname,
    required this.lastname,
  });
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // void _validateAndProceed() {
  //   String password = passwordController.text.trim();
  //   String confirmPassword = confirmPasswordController.text.trim();

  //     if (password != confirmPassword) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Passwords do not match"),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     } else if (password.isEmpty || confirmPassword.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Please fill in both fields"),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     } else {
  //       User user = User(
  //         Fname: widget.firstname,
  //         Lname: widget.lastname,
  //         Email: widget.email,
  //         Pass: password,
  //       );
  //       Manage manager = Manage();
  //       if (!manager.register(
  //         widget.firstname,
  //         widget.lastname,
  //         widget.email,
  //         password,
  //       )) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Email is already exist"),
  //             backgroundColor: Colors.red,
  //             action: SnackBarAction(
  //               label: 'Please sign in',
  //               textColor: Colors.white,
  //               onPressed: () {
  //                 Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => SignInScreen()),
  //                 );
  //               },
  //             ),
  //           ),
  //         );
  //       }
  // else{
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => HomeScreen(userr: user)),
  //       );}
  // Navigate to next screen or perform other logic
  //print("Passwords match, continue...");
  //}
  //}
  bool isValidPassword(String value) {
    if (value.isEmpty) return false;
    return value.length >= 6;
  }

  final _pass1 = GlobalKey<FormState>();
  final _pass2 = GlobalKey<FormState>();
  bool obscurePassword = true;
  // bool isValidPassword(String value) {
  //   if (value.isEmpty) return false;
  //   return value.length >= 6;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://i.postimg.cc/RZr8rktG/f31f2f8caec36cf39c3cf3532a2bca1e9002b4c2.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Create a unique password",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6D6F7C),
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 40,
                child: Form(
                  key: _pass1,
                  child: TextFormField(
                    validator: (value) {
                      String password1 = passwordController.text;
                      bool isValid = isValidPassword(password1);
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      } else if (!isValid) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "confirm your password",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6D6F7C),
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 40,
                child: Form(
                  key: _pass2,
                  child: TextFormField(
                    validator: (value) {
                      String password1 = passwordController.text;
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      } else if (password1 != value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
      
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pass1.currentState!.validate() &&
                        _pass2.currentState!.validate()) {
                      User user = User(
                        Fname: widget.firstname,
                        Lname: widget.lastname,
                        Email: widget.email,
                        Pass: passwordController.text.trim(),
                      );
                         Place dummy = Place(
                              NamePlace: "Dummy Place",
                              Country: "Nowhere",
                              Image_URL: "https://via.placeholder.com/150",
                              description:
                                  "This is a dummy place description.",
                              visited: false,
                            );
                            user.Places = [dummy];
                       
                    
                      Manage manage = Manage();
                      manage.register(
                    user,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid email'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7132F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
