import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveTestScreen extends StatefulWidget {
  const HiveTestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HiveTestScreenState createState() => _HiveTestScreenState();
}

class _HiveTestScreenState extends State<HiveTestScreen> {
  String valueFromHive = '';

  void saveData() {
    var box = Hive.box('myBox');
    box.put('name', 'Farida');
  }

  void readData() {
    var box = Hive.box('myBox');
    setState(() {
      valueFromHive = box.get('name', defaultValue: 'No name found');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: saveData,
            child: Text('احفظ الاسم'),
          ),
          ElevatedButton(
            onPressed: readData,
            child: Text('اعرض الاسم'),
          ),
          SizedBox(height: 20),
          Text(
            'النتيجة: $valueFromHive',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}