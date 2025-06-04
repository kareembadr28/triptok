import 'package:hive/hive.dart';

part 'place.g.dart';

@HiveType(typeId: 1)
class Place {
  @HiveField(0)
  String NamePlace;

  @HiveField(1)
  String description;

  @HiveField(2)
  String Image_URL;

  @HiveField(3)
  String Country;

  @HiveField(4)
  bool visited;

  Place({
    required this.NamePlace,
    required this.description,
    required this.Image_URL,
    required this.Country,
    required this.visited,
  });
}