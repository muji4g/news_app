import 'package:flutter/material.dart';

class NewsSourcesButton extends StatelessWidget {
  final Image assetImage;
  final void Function() onTap;
  final Color borderColor;
  NewsSourcesButton(
      {super.key,
      required this.assetImage,
      required this.borderColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3,
        ).copyWith(bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(27),
            child: assetImage,
          ),
        ),
      ),
    );
  }
}
