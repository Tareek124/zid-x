import 'package:flutter/material.dart';
import '../screens/ad_details_screen.dart';
import '../../constants/colors.dart';
import '../../logic/utils/functions/custom_size.dart';

class FeedPosts extends StatefulWidget {
  final Map<String, dynamic> snap;
  const FeedPosts({Key? key, required this.snap}) : super(key: key);

  @override
  State<FeedPosts> createState() => _FeedPostsState();
}

class _FeedPostsState extends State<FeedPosts> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AdDetailsScreen(
                      imageUrl: widget.snap['imageUrl'],
                      postId: widget.snap['id'],
                      uid: widget.snap['uid'],
                      price: widget.snap['price'],
                      description: widget.snap['description'],
                      name: widget.snap['name'],
                      title: widget.snap['title'],
                      phoneNumber: widget.snap['phonenumber'])))
          .whenComplete(() => setState(() {})),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 150,
              height: 70,
              child: Image.network(
                widget.snap["imageUrl"],
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              widget.snap['title'],
            ),
            subtitle: Text(widget.snap['description']),
            trailing: Text("${widget.snap['price']}  EGP"),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(
              color: darkOrange.withOpacity(0.3),
              thickness: 3,
            ),
          ),
        ],
      ),
    );
  }
}
