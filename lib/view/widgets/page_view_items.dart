import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../logic/utils/functions/custom_size.dart';

class PageViewItems extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  const PageViewItems(
      {Key? key,
      required this.imageUrl,
      required this.subTitle,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: CustomSize.defaultSize! * 20,
        ),
        SizedBox(height: 270, child: Image.asset("assets/images/$imageUrl")),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: green,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
