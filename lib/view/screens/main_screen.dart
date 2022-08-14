import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../../logic/cubit/account_info_cubit/account_info_cubit.dart';
import '../../logic/cubit/post_ad_cubit/post_ad_cubit.dart';
import 'ad_details_screen.dart';
import 'feed_screen.dart';
import 'post_ad_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

import '../../logic/utils/functions/color_mode.dart';
import '../../logic/utils/functions/custom_size.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation
  String? name;
  String? url;

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdDetailsScreen(
            imageUrl: message.data['imageurl'],
            postId: message.data['id'],
            uid: message.data['uid'],
            price: message.data['price'],
            description: message.data['description'],
            name: message.data['name'],
            title: message.data['title'],
            phoneNumber: message.data['phonenumber']),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountInfoCubit>(context).getUserInfos();
    setupInteractedMessage();
    pageController = PageController();
    print("=================================Token=========================");
    FirebaseMessaging.instance.getToken().then((value) => print(value));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    CustomSize().init(context);
    return Scaffold(
      body: BlocBuilder<AccountInfoCubit, AccountInfoState?>(
        builder: (context, state) {
          if (state is AccountInfoLoaded) {
            return PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                children: [
                  const FeedScreen(),
                  const SearchScreen(),
                  BlocProvider(
                    create: (context) => PostAdCubit(),
                    child: const PostAdScreen(),
                  ),
                  const ProfileScreen(),
                ]);
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: colorMode(context),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: colorMode(context),
              ),
              label: 'Home',
              backgroundColor: darkOrange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: colorMode(context),
              ),
              label: 'search',
              backgroundColor: darkOrange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add,
                color: colorMode(context),
              ),
              label: 'Post',
              backgroundColor: darkOrange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: colorMode(context),
              ),
              label: 'Profile',
              backgroundColor: darkOrange),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
