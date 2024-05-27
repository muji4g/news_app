import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/utils/text_styles.dart';

class NewsDetailsScreen extends StatefulWidget {
  final CachedNetworkImage image;
  final String title;
  final String details;
  final String description;
  const NewsDetailsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.details,
      required this.description});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(18), child: widget.image),
            SizedBox(
              height: size.width * 0.03,
            ),
            Text(
              widget.title,
              style: headingText.copyWith(
                  fontSize: size.width * 0.05, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              widget.details,
              style: secondaryText.copyWith(
                  color: Colors.black,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                widget.description,
                style: secondaryText.copyWith(
                    color: Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
