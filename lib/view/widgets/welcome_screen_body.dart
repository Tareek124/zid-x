import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/pages.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/widgets/custom_button.dart';
import 'custom_page_view.dart';


class WelcomeScreenBody extends StatefulWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenBody> createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  void nextPageView() {
    pageController!.nextPage(
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    CustomSize().init(context);
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController!,
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: CustomSize.defaultSize! * 25,
          child: DotsIndicator(
            decorator: DotsDecorator(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: green)),
                activeColor: green,
                color: Colors.transparent),
            dotsCount: 3,
            position: pageController!.hasClients
                ? pageController?.page as double
                : 0.0,
          ),
        ),
        Visibility(
          visible: pageController!.hasClients
              ? pageController!.page != 2
                  ? true
                  : false
              : true,
          child: Positioned(
            right: 35,
            height: CustomSize.defaultSize! * 18,
            child: TextButton(
              onPressed: () {
                pageController!.jumpToPage(2);
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: green, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          left: CustomSize.defaultSize! * 13,
          bottom: CustomSize.defaultSize! * 12,
          right: CustomSize.defaultSize! * 13,
          child: CustomButton(
              function: pageController!.hasClients
                  ? pageController!.page == 2
                      ? goToLogin
                      : nextPageView
                  : nextPageView,
              text: pageController!.hasClients
                  ? pageController!.page == 2
                      ? "Get Started"
                      : "Next"
                  : "Next"),
        ),
      ],
    );
    //! this is my body
  }
}
