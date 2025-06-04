import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:proj/Manage.dart';
import 'package:proj/PlaceSearchScreen.dart';
import 'package:proj/place_detail_screen.dart';
import 'package:proj/profilescreen.dart';
import 'package:proj/user.dart';
import 'package:proj/visitedplace.dart';

class PlacesScreen extends StatefulWidget {
  final User? user;

  PlacesScreen({required this.user});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  Manage manage = Manage();

  @override
  void initState() {
    super.initState();
    manage = Manage();
  }

  @override
  Widget build(BuildContext context) {
    final places = manage.getAllPlaces(widget.user!.Email);
    final visitedPlaces = manage.getvisitedPlaces(widget.user!.Email);
    if (visitedPlaces.length == 5) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSimpleNotification(
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFF7132F4),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Congrates you have visited 5 places!",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          background: Colors.transparent,
          elevation: 10,
          duration: const Duration(seconds: 3),
          slideDismissDirection: DismissDirection.up,
        );
      });
    }
    if (visitedPlaces.length == 10) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSimpleNotification(
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFF7132F4),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Congrates you have visited 10 places!",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          background: Colors.transparent,
          elevation: 10,
          duration: const Duration(seconds: 3),
          slideDismissDirection: DismissDirection.up,
        );
      });
    }

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: PhysicalModel(
                color: Colors.transparent,
                shadowColor: Color(0xFFEAE4FD),
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF7132F4),
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back, ${widget.user!.Fname}!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 5,
                                      color: Colors.black26,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Here are your saved places waiting for you ✨",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black26,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  places.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.travel_explore,
                              size: 100,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "There is no places added",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                              ),
                            ),
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
                                  builder:
                                      (_) => PlaceDetailScreen(
                                        user: widget.user,
                                        place: place,
                                      ),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          place.Image_URL,
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          color: Color(0xFFEAE4FD),
                                          height: 60,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  place.NamePlace,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Checkbox(
                                                  value: place.visited,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      manage.toggleVisited(
                                                        widget.user!.Email,
                                                        place.NamePlace,
                                                      );
                                                    });
                                                  },
                                                  activeColor: Color(
                                                    0xFF7132F4,
                                                  ),
                                                  checkColor: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
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
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (context) => PlaceSearchScreen(user: widget.user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => PlacesScreen(user: widget.user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyProfile(user: widget.user),
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
