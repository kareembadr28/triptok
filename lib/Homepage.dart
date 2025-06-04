import 'package:flutter/material.dart';
import 'user.dart';

class HomeScreen extends StatefulWidget {
  final User userr;

  const HomeScreen({super.key, required this.userr});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hello, ${widget.userr.Fname}!",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
