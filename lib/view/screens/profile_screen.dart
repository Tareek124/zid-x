import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/pages.dart';
import '../../logic/cubit/account_info_cubit/account_info_cubit.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/functions/signout.dart';
import '../../logic/utils/widgets/custom_button.dart';
import '../../logic/utils/widgets/progress_inndicator.dart';
import 'show_posts_from_profile.dart';
import '../../logic/utils/functions/color_mode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountInfoCubit>(context).getUserInfos();
  }

  Future<void> unsubscripe() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('adposts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorMode(context),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          TextButton(
              onPressed: () async {
                signOut();
                unsubscripe();
                Navigator.pushReplacementNamed(context, splashScreen);
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: darkOrange),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AccountInfoCubit, AccountInfoState?>(
          builder: (context, state) {
            if (state is AccountInfoLoading) {
              return progressIndicator();
            } else if (state is AccountInfoLoaded) {
              return Padding(
                padding: EdgeInsets.all(CustomSize.defaultSize! * 5),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          NetworkImage(state.accountModel.profileImage),
                    ),
                    SizedBox(
                      height: CustomSize.defaultSize! * 2,
                    ),
                    Center(
                        child: Text(
                      state.accountModel.userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: darkOrange),
                    )),
                    SizedBox(
                      height: CustomSize.defaultSize! * 2,
                    ),
                    Center(
                      child: Text(
                        state.accountModel.phoneNumber,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: darkOrange.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: CustomSize.defaultSize! * 2,
                    ),
                    Center(
                      child: Text(
                        state.accountModel.aboutYourSelf,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkOrange.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Divider(
                      color: darkOrange.withOpacity(0.3),
                      thickness: 2,
                      height: CustomSize.defaultSize! * 15,
                    ),
                    CustomButton(
                        text: "View Your Ads",
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePostsScreen(),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
