import '../../constants/colors.dart';
import '../../logic/utils/functions/color_mode.dart';
import '../widgets/show_posts_from_profile_card.dart';

import '../../logic/utils/widgets/progress_inndicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePostsScreen extends StatefulWidget {
  const ProfilePostsScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePostsScreen> createState() => _ProfilePostsScreenState();
}

class _ProfilePostsScreenState extends State<ProfilePostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: progressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => ProfilePosts(
                      snap: snapshot.data!.docs[index].data(),
                    ));
          }),
    );
  }
}
