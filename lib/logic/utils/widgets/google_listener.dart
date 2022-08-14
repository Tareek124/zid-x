import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/colors.dart';
import '../../../constants/pages.dart';
import '../../cubit/google_signin_cubit/google_sign_in_cubit.dart';
import '../../../view/screens/account_screen.dart';

import '../../cubit/account_cubit/account_cubit.dart';

class GoogleListener extends StatefulWidget {
  final BuildContext myContext;
  const GoogleListener({Key? key, required this.myContext}) : super(key: key);

  @override
  State<GoogleListener> createState() => _GoogleListenerState();
}

class _GoogleListenerState extends State<GoogleListener> {
  _showSnackBar(
      {required BuildContext context,
      required String desc,
      required String title}) {
    ScaffoldMessenger.of(widget.myContext).showSnackBar(
      SnackBar(
        content: Text(desc),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: title,
          onPressed: () {},
        ),
      ),
    );
  }

  bool doesExist = false;

  _showDialog(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocListener<GoogleSignInCubit, GoogleSignInState>(
          listenWhen: (previous, current) {
            return current != previous;
          },
          listener: (context, state) {
            if (state is GoogleSignINError) {
              Navigator.pop(widget.myContext);
              _showSnackBar(
                  context: widget.myContext, desc: state.error, title: "Error");
            } else if (state is GoogleSignInLoading) {
              showDialog(
                  context: widget.myContext,
                  builder: (context) {
                    return _showDialog(widget.myContext);
                  });
            } else if (state is GoogleSignInSuccess) {
              Navigator.pop(widget.myContext);
              Navigator.pushReplacementNamed(widget.myContext, accountScreen);
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }
}
