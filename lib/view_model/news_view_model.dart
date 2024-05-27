import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/newschannel_headline.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final rep = NewsRepository();
  Future<NewsChannelHeadLine> fetchDataFromApi(String source) async {
    final response = await rep.fetchDataFromApi(source);
    return response;
  }
}

class NewsCategoryModel {
  final rep = NewsCategoryRepository();
  Future<CategoriesNewsModel> fetchbycategory(String category) async {
    final response = await rep.fetchbyCategory(category);
    return response;
  }
}
