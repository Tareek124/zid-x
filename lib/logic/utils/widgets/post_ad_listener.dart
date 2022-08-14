import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/account_info_cubit/account_info_cubit.dart';
import '../../cubit/post_ad_cubit/post_ad_cubit.dart';
import 'progress_inndicator.dart';
import '../../../view/screens/main_screen.dart';

class PostAdListener extends StatelessWidget {
  final BuildContext accountContext;
  const PostAdListener({Key? key, required this.accountContext})
      : super(key: key);

  _showSnackBar(
      {required BuildContext context,
      required String desc,
      required String title}) {
    ScaffoldMessenger.of(accountContext).showSnackBar(
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

  _showDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(child: progressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocListener<PostAdCubit, PostAdState?>(
          listenWhen: (previous, current) {
            return current != previous;
          },
          listener: (context, state) {
            if (state is PostAdError) {
              Navigator.pop(accountContext);
              _showSnackBar(
                  context: accountContext, desc: state.error, title: "Error");
            } else if (state is PostAdLoading) {
              showDialog(
                  context: accountContext,
                  builder: (context) {
                    return _showDialog(accountContext);
                  });
            } else if (state is PostAdSuccess) {
              Navigator.pop(accountContext);
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }
}
