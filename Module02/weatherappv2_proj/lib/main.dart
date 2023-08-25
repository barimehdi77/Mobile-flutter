import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappv2_proj/models/geo_coding_model.dart';
import 'package:weatherappv2_proj/screens/current_weather_screen.dart';
import 'package:weatherappv2_proj/screens/today_weather_screen.dart';
import 'package:weatherappv2_proj/screens/weekly_weather_screen.dart';
import 'package:weatherappv2_proj/widgets/search_delegate_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Position? _currentPosition;
  bool _displayGeoLocation = false;
  bool? isPermissonsAllow;

  final TextEditingController _searchController = TextEditingController();
  GeoCodingModel? _geoCodingModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentPosition();
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location services are disabled. Please enable the services',
            ),
          ),
        );
      }
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location permissions are denied',
              ),
            ),
          );
        }
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        setState(() {
          isPermissonsAllow = false;
        });
      }
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    FocusScope.of(context).unfocus();
    _searchController.clear();

    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      setState(() {
        isPermissonsAllow = false;
      });
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        setState(() {
          _geoCodingModel = null;
          _geoCodingModel = GeoCodingModel(
            country: placemarks[0].country ?? "",
            countryCode: placemarks[0].isoCountryCode ?? "",
            elevation: 0,
            id: 0,
            latitude: position.latitude,
            longitude: position.longitude,
            name: placemarks[0].locality ?? "",
            timezone: "",
            admin1: placemarks[0].subAdministrativeArea ?? "",
          );
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      CurrentWeatherScreen(
        selectedCity: _geoCodingModel,
        isPermissonsAllow: isPermissonsAllow == null,
        displayGeoLocation: _displayGeoLocation,
        latitude: _currentPosition == null ? null : _currentPosition!.latitude,
        longitude:
            _currentPosition == null ? null : _currentPosition!.longitude,
      ),
      TodayWeatherScreen(
        selectedCity: _geoCodingModel,
        isPermissonsAllow: isPermissonsAllow == null,
        displayGeoLocation: _displayGeoLocation,
        latitude: _currentPosition == null ? null : _currentPosition!.latitude,
        longitude:
            _currentPosition == null ? null : _currentPosition!.longitude,
      ),
      WeeklyWeatherScreen(
        selectedCity: _geoCodingModel,
        isPermissonsAllow: isPermissonsAllow == null,
        displayGeoLocation: _displayGeoLocation,
        latitude: _currentPosition == null ? null : _currentPosition!.latitude,
        longitude:
            _currentPosition == null ? null : _currentPosition!.longitude,
      ),
    ];
    String? swipeDirection;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          enableInteractiveSelection: false,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search location...',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            border: InputBorder.none,
          ),
          onTap: () async {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(FocusNode());
            final selectedCity = await showSearch<GeoCodingModel?>(
              context: context,
              delegate: SearchDelegateWidget(),
              useRootNavigator: true,
              query: _searchController.text,
            );
            if (selectedCity != null) {
              _searchController.text = selectedCity.name;
            } else {
              getCurrentPosition();
            }
            setState(() {
              _displayGeoLocation = false;
              isPermissonsAllow = null;
              _geoCodingModel = selectedCity;
            });
          },
          onSubmitted: (value) {
            setState(() {
              _displayGeoLocation = false;
            });
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(
              0,
              7,
              0,
              7,
            ),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
            child: IconButton(
              onPressed: getCurrentPosition,
              icon: Transform.rotate(
                angle: 45 * pi / 180,
                child: const Icon(
                  Icons.navigation_sharp,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Currently',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
            label: 'Weekly',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      body: SizedBox.expand(
        child: GestureDetector(
          onPanUpdate: (details) {
            swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
          },
          onPanEnd: (details) {
            if (swipeDirection == null) {
              return;
            }
            if (swipeDirection == 'left') {
              setState(() {
                if (_selectedIndex < 2) _selectedIndex += 1;
              });
            }
            if (swipeDirection == 'right') {
              // handle swipe right event
              setState(() {
                if (_selectedIndex > 0) _selectedIndex -= 1;
              });
            }
          },
          child: Container(
            color: Colors.white,
            child: Center(
              child: isPermissonsAllow == false
                  ? const Text(
                      "Geolocation is not available, please enable it in your App settings",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                      textAlign: TextAlign.center,
                    )
                  : pages.elementAt(_selectedIndex),
            ),
          ),
        ),
      ),
    );
  }
}
