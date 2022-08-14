import 'package:flutter/material.dart';
import 'page_view_items.dart';

class CustomPageView extends StatefulWidget {
  final PageController pageController;
  const CustomPageView({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const PageViewItems(
            imageUrl: "zidx.png", subTitle: "", title: "Sell In an Instance"),
        const PageViewItems(
            imageUrl: "zidx_grey.png",
            subTitle: "",
            title: "Get In Touch Easy"),
        const PageViewItems(
            imageUrl: "zidx.png", subTitle: "", title: "Be Safe")
      ],
    );
  }
}
