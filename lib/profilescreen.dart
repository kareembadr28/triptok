import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj/Manage.dart';
import 'package:proj/firstscreen.dart';
import 'package:proj/place.dart';
import 'package:proj/place_screen.dart';
import 'package:proj/placesearchscreen.dart';
import 'package:proj/user.dart';

class MyProfile extends StatefulWidget {
  final User? user;
  const MyProfile({super.key, required this.user});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Manage manage = Manage();
  List<Place> visitedList = [];
  List<Place> unvisitedList = [];
  bool showVisited = false;
  bool showUnvisited = false;

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical:0,horizontal: 16.0),
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(height: 40),
    Align(
      alignment: Alignment.topLeft,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => FirstScreen(),));
        },
        icon: Icon(Icons.logout),
        label: Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF7132F4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
    SizedBox(height: 20),
    Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Icon(Icons.person, size: 50, color: Colors.black54)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              backgroundColor: Color(0xFF7132F4),
              radius: 16,
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),

              
              SizedBox(height: 20),
              Text(
                '${widget.user!.Fname} ${widget.user!.Lname}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                widget.user!.Email,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "Visited ${manage.getvisitedPlaces(widget.user!.Email).length} places ",
                  ),
                  SizedBox(width: 30),
                  Icon(Icons.flight_outlined, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "${manage.getunvistedPlaces(widget.user!.Email).length} Places to visit",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Visited Button
              SizedBox(
                width: 300,
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(219, 32),
                    backgroundColor: Color(0xFF7132F4),
                  ),
                  onPressed: () {
                    setState(() {
                      showVisited = !showVisited;
                      if (showVisited) {
                        visitedList =
                            manage.getvisitedPlaces(widget.user!.Email);
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Places you have visited',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        showVisited
                            ? Icons.arrow_downward
                            : Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              if (showVisited)
                SizedBox(
                  height: 265,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: visitedList.length,
                    itemBuilder: (context, index) {
                      final place = visitedList[index];
                      return _buildPlaceCard(place);
                    },
                  ),
                ),
              SizedBox(height: 20),
              // Unvisited Button
              SizedBox(
                width: 300,
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(219, 32),
                    backgroundColor: Color(0xFF7132F4),
                  ),
                  onPressed: () {
                    setState(() {
                      showUnvisited = !showUnvisited;
                      if (showUnvisited) {
                        unvisitedList =
                            manage.getunvistedPlaces(widget.user!.Email);
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Places you don't visit yet",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        showUnvisited
                            ? Icons.arrow_downward
                            : Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              if (showUnvisited)
                SizedBox(
                  height: 265,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: unvisitedList.length,
                    itemBuilder: (context, index) {
                      final place = unvisitedList[index];
                      return _buildPlaceCard(place);
                    },
                  ),
                ),
            ],
          ),
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
                              PlaceSearchScreen(user: widget.user),
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
                              PlacesScreen(user: widget.user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Colors.white),
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

  Widget _buildPlaceCard(Place place) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Container(
          color: Color(0xFFEAE4FD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  place.Image_URL,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.NamePlace,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(place.Country),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          place.visited
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          setState(() {
                            manage.toggleVisited(
                                widget.user!.Email, place.NamePlace);
                            visitedList =
                                manage.getvisitedPlaces(widget.user!.Email);
                            unvisitedList =
                                manage.getunvistedPlaces(widget.user!.Email);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}