import 'package:flutter/material.dart';
import 'package:proj/emailscreen.dart';
import 'package:proj/signinscreen.dart';
import 'FirstScreen.dart';

class FLname extends StatefulWidget {
  const FLname({Key? key}) : super(key: key);

  @override
  State<FLname> createState() => _FLnameState();
}

class _FLnameState extends State<FLname> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool isValidName(String value) {
    if (value.isEmpty) return false;
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    return nameExp.hasMatch(value);
  }

  bool isValidEmail(String value) {
    if (value.isEmpty) return false;
    final emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailExp.hasMatch(value);
  }

  final _fname = GlobalKey<FormState>();
  final _lname = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://i.postimg.cc/RZr8rktG/f31f2f8caec36cf39c3cf3532a2bca1e9002b4c2.png",
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                "First Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Enter your first name.",
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
                  key: _fname,
                  child: TextFormField(
                    validator: (value) {
                      String firstname = firstNameController.text;
                      bool isValidFname = isValidName(firstname);
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      } else if (!isValidFname) {
                        return 'Please enter a valid name (letters only)';
                      }
                      return null;
                    },
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Last Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Enter your last name.",
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
                  key: _lname,
                  child: TextFormField(
                    validator: (value) {
                      String lastname = lastNameController.text;
                      bool isValidLname = isValidName(lastname);
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      } else if (!isValidLname) {
                        return 'Please enter a valid name (letters only)';
                      }
                      return null;
                    },
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    if (_fname.currentState!.validate() &&
                        _lname.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (context) => EmailScreen(
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                              ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter a valid name (letters only)',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7132F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAE4FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "I already have an account",
                    style: TextStyle(fontSize: 18, color: Color(0xFF7132F4)),
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
