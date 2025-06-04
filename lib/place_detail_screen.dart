import 'package:flutter/material.dart';
import 'package:proj/Manage.dart';
import 'package:proj/place.dart';
import 'package:proj/place_screen.dart';
import 'package:proj/placesearchscreen.dart';
import 'package:proj/profilescreen.dart';
import 'package:proj/user.dart';

class PlaceDetailScreen extends StatelessWidget {
  final User? user;
  final Place place;

  PlaceDetailScreen({required this.user, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          title: Text(place.NamePlace),
          backgroundColor: Colors.transparent, // Make AppBar transparent for better look
          elevation: 0, // Remove the shadow
        ),
        body: ListView(
          children: [
            // Circular Image
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16), // Circular border for image
                child: Image.network(
                  place.Image_URL,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Description Text
            // Description Text
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
  child: Container(
    decoration: BoxDecoration(
      color: Color(0xFFEAE4FD).withOpacity(0.8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: EdgeInsets.all(16),
    child: Text(
      place.description,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    ),
  ),
),

            SizedBox(height: 20),
            // Delete Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7132F4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Manage manage = Manage();
                  manage.removePlace(user!.Email, place.NamePlace);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlacesScreen(user: user),
                    ),
                  );
                },
                icon: Icon(Icons.delete),
                label: Text(
                  "Delete from favorite",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            color: Color(0xFF7132F4),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              PlaceSearchScreen(user: user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              PlacesScreen(user: user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyProfile(user: user),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
