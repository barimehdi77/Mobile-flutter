import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappv2_proj/models/geo_coding_model.dart';
import 'package:weatherappv2_proj/search_delegate_widget.dart';

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
  bool displayGeoLocation = false;
  bool? isPermissonsAllow;

  final TextEditingController _searchController = TextEditingController();
  GeoCodingModel? geoCodingModel;

  static const List<Widget> pages = [
    Text(
      'Currently',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    Text(
      'Today',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    Text(
      'Weekly',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;

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
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) {
        setState(() {
          isPermissonsAllow = false;
        });
      }
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          displayGeoLocation = true;
          _currentPosition = position;
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
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
            final selectedCity = await showSearch<GeoCodingModel?>(
              context: context,
              delegate: SearchDelegateWidget(),
              useRootNavigator: true,
              query: _searchController.text,
            );
            if (selectedCity != null) {
              _searchController.text = selectedCity.name;
            } else {
              _searchController.text = "";
            }
            print(selectedCity?.name);
          },
          // onTap: () {
          //   showModalBottomSheet(
          //     context: context,
          //     isScrollControlled: true,
          //     constraints: BoxConstraints.loose(
          //       Size(
          //         MediaQuery.of(context).size.width,
          //         MediaQuery.of(context).size.height,
          //       ),
          //     ),
          //     builder: (context) {
          //       return Container(
          //         height: MediaQuery.of(context).size.height - 118,
          //         color: Colors.amber,
          //         child: const Wrap(
          //           children: [
          //             ListTile(
          //               leading: Icon(Icons.share),
          //               title: Text('Share'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.copy),
          //               title: Text('Copy Link'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.edit),
          //               title: Text('Edit'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.edit),
          //               title: Text('Edit'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.edit),
          //               title: Text('Edit'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.edit),
          //               title: Text('Edit'),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   );
          // },
          onSubmitted: (value) {
            setState(() {
              displayGeoLocation = false;
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
              // handle swipe left event
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isPermissonsAllow == null)
                    pages.elementAt(_selectedIndex),
                  if (isPermissonsAllow == null)
                    Text(
                      displayGeoLocation == true
                          ? '${_currentPosition?.latitude ?? ""} ${_currentPosition?.longitude ?? ""}'
                          : _searchController.text,
                    ),
                  if (isPermissonsAllow == false)
                    const Text(
                      "Geolocation is not available, please enable it in your App settings",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                      textAlign: TextAlign.center,
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
