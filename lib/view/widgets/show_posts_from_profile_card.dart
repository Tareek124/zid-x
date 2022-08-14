import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/functions/get_user_id.dart';
import '../screens/ad_details_screen.dart';

class ProfilePosts extends StatefulWidget {
  Map<String, dynamic> snap;
  ProfilePosts({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  @override
  Widget build(BuildContext context) {
    if (getUserId() == widget.snap['uid']) {
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
            Card(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 5.0,
              ),
              child: Hero(
                tag: widget.snap['id'],
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(widget.snap['imageUrl']))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.snap['title'],
                      style: const TextStyle(
                          fontSize: 25,
                          color: darkOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              widget.snap['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15, color: darkOrange, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.snap['price']}   EGP",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15, color: darkOrange, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: darkOrange.withOpacity(0.5),
            ),
            SizedBox(
              height: CustomSize.defaultSize! * 7,
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
