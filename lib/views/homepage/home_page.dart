import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/news_source_model.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/newschannel_headline.dart';
import 'package:news_app/views/categoryscreen/category_screen.dart';
import 'package:news_app/views/homepage/components/channel_listview.dart';
import 'package:news_app/views/homepage/components/components.dart';
import 'package:news_app/views/news_details/news_details.dart'; // Ensure this is imported to use NewsChannelHeadLine

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsViewModel newsView = NewsViewModel();
  String source = 'bbc-news';
  final NewsSources newsSources = NewsSources();
  Color borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Text(
            'RAPID NEWS',
            style: logoFont.copyWith(
                fontSize: size.width * 0.06,
                color: primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewsByCategoryScreen()));
              },
              icon: Icon(
                Ionicons.apps_outline,
                color: primaryColor,
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.07,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {
                        setState(() {
                          borderColor = primaryColor;
                          source = newsSources.bbcID;
                        });
                      },
                      assetImage: Image.asset('assets/images/bbc-logo.jpg'),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {
                        setState(() {
                          source = newsSources.abcID;
                          borderColor = primaryColor;
                        });
                      },
                      assetImage: Image.asset('assets/images/abc-logo.jpg'),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () => (setState(() {
                        borderColor = primaryColor;
                        source = newsSources.alJazeeraID;
                      })),
                      assetImage: Image.asset(
                        'assets/images/Al-jazeera.png',
                      ),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {
                        setState(() {
                          source = newsSources.arstechID;
                          borderColor = primaryColor;
                        });
                      },
                      assetImage: Image.asset(
                        'assets/images/ars-logo.png',
                      ),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {},
                      assetImage: Image.asset(
                        'assets/images/ap-logo.jpg',
                      ),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {},
                      assetImage: Image.asset(
                        'assets/images/axios.png',
                      ),
                    ),
                    NewsSourcesButton(
                      borderColor: Colors.black,
                      onTap: () {},
                      assetImage: Image.asset(
                        'assets/images/bloomberg.png',
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top Headlines',
                style: headingText.copyWith(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: FutureBuilder<NewsChannelHeadLine>(
                future: newsView.fetchDataFromApi(source),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset('assets/images/loading.json',
                          width: size.width * 0.8),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Lottie.asset('assets/images/failed.json',
                          repeat: false, width: size.width * 0.5),
                    );
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
                          height: size.height * 0.8,
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
                                                  description: snapshot.data!
                                                      .articles![index].content
                                                      .toString(),
                                                  image: CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage
                                                          .toString()),
                                                  title: snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  details: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .description
                                                      .toString())));
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          imageUrl: data![index]
                                              .urlToImage
                                              .toString(),
                                          errorWidget: (context, url, error) {
                                            return Center(
                                              child: Lottie.asset(
                                                  'assets/images/failed.json',
                                                  repeat: false,
                                                  width: size.width * 0.5),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return Center(
                                              child: Lottie.asset(
                                                  'assets/images/image_loading.json',
                                                  width: size.width * 0.5),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: size.height * 0.17,
                                      left: size.width * 0.02,
                                      child: SizedBox(
                                        width: size.width * 0.78,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 4, sigmaY: 4),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: const Color.fromARGB(
                                                          255, 105, 105, 105)
                                                      .withOpacity(0.5)),
                                              child: SizedBox(
                                                height: size.height * 0.2,
                                                child: Text(
                                                  data[index]
                                                      .title
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: headlineText.copyWith(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: size.height * 0.37,
                                      left: size.width * 0.9,
                                      child: SizedBox(
                                        width: size.width * 0.7,
                                        child: Text(
                                          data[index]
                                              .publishedAt
                                              .toString()
                                              .trim(),
                                          style: headlineText.copyWith(
                                              fontSize: size.width * 0.035,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
      ),
    );
  }
}
