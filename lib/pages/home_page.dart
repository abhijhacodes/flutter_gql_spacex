import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gql_spacex/helpers/queries.dart';
import 'package:flutter_gql_spacex/helpers/types.dart';
import 'package:flutter_gql_spacex/widgets/launch_card.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> launches;
  late bool isLoading;
  late String error;
  late int totalPages = 0;
  late int currentPage = -1;
  late int itemsInCurrentPage;

  @override
  void initState() {
    super.initState();
    launches = [];
    isLoading = true;
    error = "";
    getUpcomingLaunches();
  }

  Future<void> getUpcomingLaunches() async {
    try {
      final Uri apiEndpoint =
          Uri.parse("https://main--spacex-l4uc6p.apollographos.net/graphql");
      final Map<String, String> requestHeaders = {
        "Content-Type": "application/json"
      };
      final Object requestBody =
          jsonEncode({'query': getUpcomingLaunchesQuery});

      final response = await http.post(apiEndpoint,
          headers: requestHeaders, body: requestBody);

      final launchesData = jsonDecode(response.body)['data']['launches'];
      setState(() {
        launches = launchesData.map((data) {
          return LaunchType(
            missionName: data['mission_name'] ?? "",
            launchDate: data['launch_date_local'] ?? "",
            rocketName: data['rocket']['rocket_name'] ?? "",
            details: data['details'] ?? "",
          );
        }).toList();
        totalPages = (launches.length / 20).ceil();
        currentPage = 0;
        isLoading = false;
        error = "";
      });
      changePage(0);
    } catch (e) {
      setState(() {
        launches = [];
        isLoading = false;
        error = e.toString();
      });
    }
  }

  void changePage(int page) {
    setState(() {
      currentPage = page;
      itemsInCurrentPage =
          page == (totalPages - 1) ? launches.length - (page * 20) : 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget launchCards;

    if (isLoading) {
      launchCards = const CircularProgressIndicator();
    } else if (error.isNotEmpty) {
      launchCards = Text("Something went wrong\n $error");
    } else {
      double screenWidth = MediaQuery.of(context).size.width;

      launchCards = GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemCount: itemsInCurrentPage,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 1200
                ? 4
                : screenWidth > 900
                    ? 3
                    : screenWidth > 600
                        ? 2
                        : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: screenWidth > 1200
                ? 1.3
                : screenWidth > 900
                    ? 1.1
                    : screenWidth > 600
                        ? 1.2
                        : 1.3),
        itemBuilder: (BuildContext context, int index) {
          final LaunchType launchDetails = launches[(currentPage * 20) + index];
          return LaunchCard(launchDetails: launchDetails);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("SpaceX upcoming launches"),
          SizedBox(width: 10),
          Icon(Icons.rocket_launch)
        ],
      )),
      body: Column(
        children: [
          if (currentPage != -1)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  "Page: ${currentPage + 1}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: launchCards,
            ),
          ),
          if (totalPages > 0)
            Container(
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalPages,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        onPressed: () {
                          changePage(index);
                        },
                        child: CustomText(
                          content: (index + 1).toString(),
                          textType: TextTypes.medium,
                        ));
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
