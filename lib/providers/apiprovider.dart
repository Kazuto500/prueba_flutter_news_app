import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiProvider with ChangeNotifier {
  bool isGettingData = false;

  List<String> categories = [
    "general",
    "business",
    "entertainment",
    "science",
    "health",
    "sports",
    "technology",
  ];

  getPosts(int currentCategoryIndex) async {
    try {
      isGettingData = true;
      final httpResponse = await get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=us&category=${categories[currentCategoryIndex]}&apiKey=27f91dd47a7d43d682f6c1d3cc5775d9"),
      );
      if (httpResponse.statusCode == 200) {
        isGettingData = false;
        return utf8.decode(httpResponse.bodyBytes);
      } else {
        isGettingData = false;
        return null;
      }
    } catch (e) {
      isGettingData = false;
      return e;
    }
  }
}
