import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart' show MaterialApp, runApp;
import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:proj/place.dart';
import 'package:proj/triptokscreen.dart';
import 'package:proj/user.dart';
//import 'package:proj/PlacesScreen.dart'; // تأكد من تضمين هذه الشاشة

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PlaceAdapter());
  await Hive.openBox("Users");
  await Hive.openBox("mybox");
  
  runApp(const TripTokApp());
}

class TripTokApp extends StatelessWidget {
  const TripTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global( // تضمين OverlaySupport هنا
      child: MaterialApp(
        home: TripTokScreen(), // هنا يمكنك وضع الشاشات الخاصة بك
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
