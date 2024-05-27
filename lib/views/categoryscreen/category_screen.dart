import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/categories_news_model.dart';

import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/news_details/news_details.dart';

class NewsByCategoryScreen extends StatefulWidget {
  const NewsByCategoryScreen({super.key});

  @override
  State<NewsByCategoryScreen> createState() => NewsByCategoryScreenState();
}

class NewsByCategoryScreenState extends State<NewsByCategoryScreen> {
  NewsCategoryModel categoryModel = NewsCategoryModel();
  List<String> categories = [
    'General',
    'Business',
    'Entertainment',
    'Technology',
    'Sports',
    'Health',
    'Science'
  ];
  String category = '';
  String source = 'cnn';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.05,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        category = categories[index];
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.004,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: category == categories[index]
                                ? Colors.black
                                : secondaryColor),
                        child: Text(
                          categories[index],
                          style: secondaryText,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: size.height * 0.8,
            child: FutureBuilder<CategoriesNewsModel>(
              future: categoryModel.fetchbycategory(category),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset('assets/images/loading.json',
                        width: size.width * 0.8),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Column(
                    children: [
                      Lottie.asset('assets/images/failed.json',
                          repeat: false, width: size.width * 0.5),
                      Text(
                        snapshot.error.toString(),
                        style: secondaryText.copyWith(color: Colors.black),
                      )
                    ],
                  ));
                } else if (!snapshot.hasData ||
                    snapshot.data?.articles == null ||
                    snapshot.data!.articles!.isEmpty) {
                  return Center(
                    child: Text('No news available'),
                  );
                } else {
                  final data = snapshot.data!.articles;
                  return ListView(
                    children: [
                      SizedBox(
                        height: size.height * 0.75,
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailsScreen(
                                                    image: CachedNetworkImage(
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                        child: Lottie.asset(
                                                          'assets/images/failed.json',
                                                          repeat: false,
                                                        ),
                                                      ),
                                                      imageUrl: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage
                                                          .toString(),
                                                    ),
                                                    title: snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    details: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    description: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString())));
                                  },
                                  child: ListTile(
                                    leading: CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Lottie.asset(
                                          'assets/images/failed.json',
                                          repeat: false,
                                        ),
                                      ),
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                    ),
                                    title: Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      style: headingText.copyWith(fontSize: 12),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
