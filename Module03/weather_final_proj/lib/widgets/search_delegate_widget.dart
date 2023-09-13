import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/geo_coding_model.dart';

class SearchDelegateWidget extends SearchDelegate<GeoCodingModel?> {
  Future<List<GeoCodingModel>> serachdb(
      searchData, BuildContext context, bool isSearch) async {
    var url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$searchData&count=5&language=en&format=json';
    final dio = Dio();
    final response = await dio.get<Map>(url);
    if (response.data == null) return [];
    if (response.data!.containsKey('results')) {
      if (context.mounted && !isSearch) {
        close(context, GeoCodingModel.fromJson(response.data!['results'][0]));
      }
      return GeoCodingModel.fromJsonList(response.data!['results']);
    } else {
      return [];
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: serachdb(query, context, false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: snapshot.data == null
                ? const Text('No Data')
                : snapshot.data!.isEmpty
                    ? const Center(child: Text("City Not found "))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          GeoCodingModel result = snapshot.data![index];
                          return GestureDetector(
                            child: ListTile(
                              leading: const Icon(
                                Icons.apartment_sharp,
                                color: Colors.white,
                              ),
                              title: Text(
                                result.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                result.admin1,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                result.country,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              close(context, snapshot.data![index]);
                            },
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: serachdb(query, context, true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: snapshot.data == null
                ? const Text('No Data')
                : snapshot.data!.isEmpty
                    ? const Center(child: Text("City Not found "))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          GeoCodingModel result = snapshot.data![index];
                          return GestureDetector(
                            child: ListTile(
                              leading: const Icon(
                                Icons.apartment_sharp,
                                color: Colors.white,
                              ),
                              title: Text(
                                result.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                result.admin1,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                result.country,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              close(context, snapshot.data![index]);
                            },
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.black, // AppBar backgound color
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white, // cursor color
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            // decorationThickness: 0.0000001, // input text underline
            color: Colors.white // input text color
            ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none, // input field border
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 15,
            ), // hint text color
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search location...';
}
