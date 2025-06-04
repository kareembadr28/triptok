import 'package:hive/hive.dart';
import 'package:proj/place.dart';
import 'package:proj/user.dart';

class Manage {
  var box = Hive.box("Users");

  Future<void> addDummyUser() async {
    User user1 = User(
      Fname: 'Ahmed',
      Lname: "Mohamed",
      Email: "Ahmed@gmail.com",
      Pass: "123456789",
      Places: [
        Place(
          NamePlace: "Dummy Place",
          description: "This is a dummy place",
          Image_URL: "https://dummyimage.com/600x400/000/fff",
          Country: "Nowhere",
          visited: false,
        ),
      ],
    );

    await box.put("Ahmed@gmail.com", user1);
    print('Dummy user with dummy place added!');
  }

  bool Login(String mail, String password) {
    User? user = box.get(mail);
    if (box.containsKey(mail) && user?.Pass == password) return true;
    return false;
  }

  bool isUserExist(String mail) {
    return box.containsKey(mail);
  }

  User? getUser(String mail) {
    return box.get(mail);
  }

  bool register(User user) {
    if (!box.containsKey(user.Email)) {
      // Add dummy place to new user
      user.Places = [
        Place(
          NamePlace: "Dummy Place",
          description: "This is a dummy place",
          Image_URL: "https://dummyimage.com/600x400/000/fff",
          Country: "Nowhere",
          visited: false,
        ),
      ];
      box.put(user.Email, user);
      print(
        "User with name ${user.Fname} ${user.Lname} and email ${user.Email} added successfully",
      );
      return true;
    }
    return false;
  }

  bool addPlace({
    required String username,
    required String name,
    required String description,
    required String imageUrl,
    required String country,
  }) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return false;

    if (!user.Places.any((p) => p.NamePlace == name)) {
      Place place = Place(
        NamePlace: name,
        description: description,
        Image_URL: imageUrl,
        Country: country,
        visited: false,
      );
      user.Places.add(place);
      box.put(username, user);
      return true;
    }
    return false;
  }

  bool removePlace(String username, String placeName) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return false;

    user.Places.removeWhere((p) => p.NamePlace == placeName);
    box.put(username, user);
    return true;
  }

  List<Place> getAllPlaces(String username) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return [];
    return user.Places
        .where((p) => p.NamePlace.toLowerCase() != "dummy place")
        .toList();
  }

  List<Place> getvisitedPlaces(String username) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return [];
    return user.Places
        .where(
          (p) =>
              p.NamePlace.toLowerCase() != "dummy place" && p.visited == true,
        )
        .toList();
  }

  List<Place> getunvistedPlaces(String username) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return [];
    return user.Places
        .where(
          (p) =>
              p.NamePlace.toLowerCase() != "dummy place" && p.visited == false,
        )
        .toList();
  }

  List<Place> filterByCountry(String username, String country) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return [];
    return user.Places
        .where(
          (p) =>
              p.Country.toLowerCase() == country.toLowerCase() &&
              p.NamePlace.toLowerCase() != "dummy place",
        )
        .toList();
  }

  // 🟡⬇⬇ أضفت الميثود دي عشان تقلب حالة visited ⬇⬇🟡
  bool toggleVisited(String username, String placeName) {
    User? user = box.get(username);
    if (user == null || !isUserExist(username)) return false;

    int index = user.Places.indexWhere((p) => p.NamePlace == placeName);
    if (index != -1) {
      user.Places[index].visited = !user.Places[index].visited;
      box.put(username, user); // نحفظ التعديل في Hive

      // 👇 مهم: نجيب نسخة محدثة من الـ box عشان الـ UI يشتغل صح
      user = box.get(username);

      return true;
    }
    return false;
  }
}