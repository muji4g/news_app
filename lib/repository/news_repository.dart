import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_services/domains.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/newschannel_headline.dart';

class NewsRepository {
  Future<NewsChannelHeadLine> fetchDataFromApi(String source) async {
    final String url = apiDomainsource(source);
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadLine.fromJson(body);
    }

    throw Exception('Error');
  }
}

class NewsCategoryRepository {
  Future<CategoriesNewsModel> fetchbyCategory(String category) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0a4de3c09b22407cbdfe14d90968628d';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }

    throw Exception('Error');
  }
}
