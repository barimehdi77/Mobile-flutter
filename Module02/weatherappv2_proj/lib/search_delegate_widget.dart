import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weatherappv2_proj/models/geo_coding_model.dart';

class SearchDelegateWidget extends SearchDelegate {
  // List<String> searchTerms = [
  //   'Apple',
  //   'Banana',
  //   "Pear",
  //   "Watermelons",
  //   "Oranges",
  //   "Blueberries",
  //   "Strawberries",
  //   "Raspberries",
  // ];

  Future<List<GeoCodingModel>> serachdb(searchData) async {
    print('hellp');
    var url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$searchData&count=100&language=en&format=json';
    final dio = Dio();
    final response = await dio.get<Map>(url);
    print('response: ');
    print(response);
    print(response.data!.containsKey('results'));
    if (response.data!.containsKey('results')) {
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
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: serachdb(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data!.isEmpty
              ? const Center(child: Text("City Not found "))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var result = Text(snapshot.data![index].name);
                    return GestureDetector(
                      child: ListTile(title: result),
                      onTap: () {
                        close(context, snapshot.data![index]);
                      },
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: serachdb(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return snapshot.data!.isEmpty
                ? const Center(child: Text("City Not found "))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      var result = Text(snapshot.data![index].name);
                      return GestureDetector(
                        child: ListTile(title: result),
                        onTap: () {
                          close(context, snapshot.data![index]);
                        },
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.blue, // AppBar backgound color
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
