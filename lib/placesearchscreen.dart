import 'dart:convert';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:proj/Manage.dart';
import 'package:proj/place_screen.dart';
import 'package:proj/profilescreen.dart';
import 'package:proj/user.dart';

class PlaceSearchScreen extends StatefulWidget {
  final User? user;

  const PlaceSearchScreen({super.key, required this.user});

  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  List<Country> countries = [];
  Country? selectedCountry;
  final TextEditingController countryController = TextEditingController();

  List<String> allCities = [];
  String? selectedCity;
  final TextEditingController cityController = TextEditingController();
  bool isLoadingCities = false;
  final String apiKey = 'farida_emad_ibrahim';
  bool isChecked = false;
  String? imageUrl;
  String? description;
  int currentIndex = 0;

  Future<String?> getimage(String placeName) async {
    const String unsplashApiKey = "I2MldcG71CfebV611awLLCv-NwI-XkJifjfHWIbQccc";
    final url = Uri.parse(
      'https://api.unsplash.com/search/photos?query=$placeName&client_id=$unsplashApiKey',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        return data['results'][0]['urls']['regular'];
      }
    }
    return null;
  }

  Future<String?> getdesc(String placeName) async {
    final url = Uri.parse(
      'https://en.wikipedia.org/api/rest_v1/page/summary/$placeName',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['extract'];
    }
    return null;
  }

  Future<void> searchPlace() async {
    final place = selectedCity!.trim();
    if (place.isEmpty) return;

    setState(() {
      isLoadingCities = true;
      imageUrl = null;
      description = null;
      allCities = [];
      countryController.clear();
      cityController.clear();
      isChecked = false; // هنا بنرجّع القلب لحالته الفاضية
    });

    final img = await getimage(place);
    final desc = await getdesc(place);

    setState(() {
      imageUrl = img;
      description = desc;
      isLoadingCities = false;
    });
  }

  Future<void> getCitiesForCountry(String countryCode) async {
    final url = Uri.parse(
      'http://api.geonames.org/searchJSON?country=$countryCode&featureClass=P&maxRows=1000&username=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['geonames'] != null) {
        setState(() {
          allCities = List<String>.from(
            data['geonames'].map((city) => city['name'] as String),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    countries = CountryService().getAll();
  }

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
                  backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Color(0xFF7132F4),
                      child: Text(
                        'T',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "TripTok",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              TypeAheadFormField<Country>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFEAE4FD),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return countries.where(
                    (country) => country.name.toLowerCase().startsWith(
                      pattern.toLowerCase(),
                    ),
                  );
                },
                itemBuilder: (context, Country suggestion) {
                  return ListTile(
                    leading: Text(suggestion.flagEmoji),
                    title: Text(suggestion.name),
                  );
                },
                onSuggestionSelected: (Country suggestion) async {
                  setState(() {
                    selectedCountry = suggestion;
                    countryController.text =
                        suggestion.flagEmoji + ' ' + suggestion.name;
                    allCities = [];
                    selectedCity = null;
                    cityController.clear();
                    isLoadingCities = true;
                    isChecked =
                        false; // نرجع القلب لحالته الفاضية عند تغيير الدولة
                  });
      
                  await getCitiesForCountry(suggestion.countryCode);
      
                  setState(() {
                    isLoadingCities = false;
                  });
                },
                noItemsFoundBuilder:
                    (context) => Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("There is no Country with this name"),
                    ),
              ),
              SizedBox(height: 12),
              TypeAheadFormField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFEAE4FD),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty || allCities.isEmpty) return [];
                  return allCities
                      .where(
                        (city) =>
                            city.toLowerCase().startsWith(pattern.toLowerCase()),
                      )
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(title: Text(suggestion));
                },
                onSuggestionSelected: (String suggestion) async {
                  setState(() {
                    selectedCity = suggestion;
                    cityController.text = suggestion;
                    isChecked =
                        false; 
                  });
                  searchPlace();
                },
                noItemsFoundBuilder:
                    (context) => Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("There is no City"),
                    ),
              ),
              SizedBox(height: 16),
              if (isLoadingCities)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircularProgressIndicator(),
                )
              else if (selectedCity != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                if (imageUrl != null && description != null)
                                  Column(
                                    children: [
                                      Image.network(
                                        imageUrl!,
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        color: Color(0xFFEAE4FD),
                                        height: 200,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            description!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Text("Image not available"),
                                    ),
                                  ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    iconSize: 28,
                                    icon: Icon(
                                      isChecked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isChecked
                                              ? Color(0xFF7132F4)
                                              : Colors.white,
                                    ),
                                    onPressed: () async {
                                      Manage manage = Manage();
                                      String email = widget.user!.Email;
      
                                      if (isChecked) {
                                        // لو هو متعلم هنشيله من الفيفوريت
                                        await manage.removePlace(email,selectedCity!);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Place removed from favorites",
                                            ),
                                          ),
                                        );
                                      } else {
                                        await manage.addPlace(
                                          username: email,
                                          name: selectedCity!,
                                          description: description!,
                                          imageUrl: imageUrl!,
                                          country: selectedCountry!.name,
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Place added to favorites",
                                            ),
                                          ),
                                        );
                                      }
      
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      color:
                          currentIndex == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
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
                      color:
                          currentIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                      });
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
                      color:
                          currentIndex == 2
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyProfile(
                          user: widget.user,
                          )),
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