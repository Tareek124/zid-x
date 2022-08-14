import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/colors.dart';
import '../../logic/cubit/google_signin_cubit/google_sign_in_cubit.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/widgets/custom_button.dart';
import '../../logic/utils/widgets/google_listener.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              GoogleListener(myContext: context),
              SvgPicture.asset(
                "assets/svg/zid_x_svg.svg",
                color: darkOrange,
              ),
              Row(
                children: [
                  CustomSignInButton(
                      imageUrl: 'google.png',
                      title: "google",
                      function: () {
                        BlocProvider.of<GoogleSignInCubit>(context)
                            .signInWithGoogle();
                      }),
                  SizedBox(
                    width: CustomSize.defaultSize! * 1.99,
                  ),
                  CustomSignInButton(
                      imageUrl: 'facebook.png',
                      title: "Facebook",
                      function: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
