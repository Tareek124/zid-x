import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../logic/utils/functions/delete_post.dart';
import '../../logic/utils/functions/get_user_id.dart';
import '../../logic/utils/widgets/custom_button.dart';

class AdDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String postId;
  final String title;
  final String description;
  final String phoneNumber;
  final String price;
  final String uid;
  const AdDetailsScreen(
      {Key? key,
      required this.imageUrl,
      required this.postId,
      required this.uid,
      required this.price,
      required this.description,
      required this.name,
      required this.title,
      required this.phoneNumber})
      : super(key: key);

  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 450,
      leadingWidth: double.infinity,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          name,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: darkOrange, fontWeight: FontWeight.bold),
        ),
        background: Hero(
          tag: postId,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String desc) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      text: TextSpan(children: [
        TextSpan(
          text: "$title :   ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: darkOrange),
        ),
        TextSpan(
          text: desc,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 22, color: darkOrange),
        )
      ]),
    );
  }

  Widget buildDivider(double height) {
    return Divider(
      height: 30,
      endIndent: height,
      color: darkOrange.withOpacity(0.3),
      thickness: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo("Name", name),
                      buildDivider(80),
                      characterInfo("Title", title),
                      buildDivider(170),
                      characterInfo("Description", description),
                      buildDivider(30),
                      characterInfo("Price", "$price EGP"),
                      buildDivider(170),
                      characterInfo("Phone Number", phoneNumber),
                      buildDivider(30),
                      const SizedBox(
                        height: 35,
                      ),
                      getUserId() == uid
                          ? CustomButton(
                              text: "Delete Post",
                              function: () {
                                deletePost(postId: postId);
                                Navigator.pop(context);
                              })
                          : const SizedBox(),
                      const SizedBox(
                        height: 230,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
