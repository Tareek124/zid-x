import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/constants/colors.dart';
import '../../constants/pages.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);
  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationContoller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    animationContoller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationContoller!);
    animationContoller?.repeat(reverse: true);
    goToWelcome();
  }

  void goToWelcome() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, welcomeScreen);
    });
  }

  @override
  void dispose() {
    animationContoller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FadeTransition(
            opacity: animationContoller!,
            child: const Text(
              "ZID-X",
              style: TextStyle(
                  color: darkOrange,
                  fontFamily: 'Poppins',
                  fontSize: 51,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Spacer(),
        Center(
          child: SvgPicture.asset(
            "assets/svg/zid_x_svg.svg",
            color: darkOrange,
          ),
        )
      ],
    );
  }
}
