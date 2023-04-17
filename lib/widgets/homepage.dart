import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prueba_flutter_news_app/providers/apiprovider.dart';

import 'package:prueba_flutter_news_app/widgets/news_cards_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ApiProvider api = ApiProvider();

  int categoryIndex = 0;

  void _setCurrentCategory(int newIndex) {
    setState(
      () {
        try {
          categoryIndex = newIndex;
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.easeOut,
          );
          api.getPosts(newIndex);
        } catch (e) {
          null;
        }
      },
    );
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 64),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: categoryIndex,
          showUnselectedLabels: true,
          onTap: (index) => _setCurrentCategory(index),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 96, 96, 96),
              icon: Icon(Icons.newspaper_rounded),
              label: "General",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_rounded),
              label: "Business",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_roll_rounded),
              label: "Entertainment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.science_rounded),
              label: "Science",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monitor_heart_rounded),
              label: "Health",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer_rounded),
              label: "Sports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer_rounded),
              label: "Technology",
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: api.getPosts(categoryIndex),
        builder: (context, snapshot) {
          if (api.isGettingData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff202020),
              ),
            );
          } else if (snapshot.data.toString().contains("Failed host lookup")) {
            return const Center(
              child: Text("Network error"),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return const Center(
              child: Text("Data not found"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            dynamic data = jsonDecode(snapshot.data.toString())['articles'];
            return ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: 0),
              itemCount: data.length,
              itemBuilder: (context, index) => NewsCard(
                postIndex: index + 1,
                providerName: data[index]['source']['name'],
                postTitle: data[index]['title'],
                imageUrl: data[index]['urlToImage'],
                postContent: data[index]['content'],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff202020),
              ),
            );
          }
        },
      ),
    );
  }
}
