import 'package:hive/hive.dart';
import 'place.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String Fname;

  @HiveField(1)
  String Lname;

  @HiveField(2)
  String Email;

  @HiveField(3)
  String Pass;

  @HiveField(4)
  List<Place> Places;

  User({
    required this.Fname,
    required this.Lname,
    required this.Email,
    required this.Pass,
    List<Place>? Places,
  }) : Places = Places ?? [];
}