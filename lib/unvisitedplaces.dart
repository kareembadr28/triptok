import 'package:flutter/material.dart';
import 'package:proj/Manage.dart';
import 'package:proj/place_detail_screen.dart';
import 'package:proj/user.dart';

class unVisitedPlaces extends StatelessWidget {
  final User? user;
  final Manage manage = Manage();

  unVisitedPlaces({required this.user});

  @override
  Widget build(BuildContext context) {
    final places = manage.getunvistedPlaces(user!.Email);

    return Scaffold(
      appBar: AppBar(
        title: Text("الأماكن التي لم تُزر بعد"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: places.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty, size: 100, color: Colors.grey),
                        SizedBox(height: 20),
                        Text("لا توجد أماكن غير مُزارة", style: TextStyle(fontSize: 22, color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final place = places[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaceDetailScreen(user: user, place: place),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  place.Image_URL,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 200,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: Text(
                                  place.NamePlace,
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text("الرجوع"),
            ),
          ),
        ],
      ),
    );
  }
}
