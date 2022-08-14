import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ad_details_screen.dart';

import '../../logic/utils/widgets/progress_inndicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a product...',
              ),
              onChanged: (String _) {
                setState(() {
                  isSearching = true;
                });
              },
            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('posts')
              .where(
                'title',
                isLessThanOrEqualTo: searchController.text,
              )
              .get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: progressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AdDetailsScreen(
                            imageUrl: snapshot.data!.docs[index]['imageUrl'],
                            postId: snapshot.data!.docs[index]['id'],
                            uid: snapshot.data!.docs[index]['uid'],
                            price: snapshot.data!.docs[index]['price'],
                            description: snapshot.data!.docs[index]
                                ['description'],
                            name: snapshot.data!.docs[index]['name'],
                            title: snapshot.data!.docs[index]['title'],
                            phoneNumber: snapshot.data!.docs[index]
                                ['phonenumber']))),
                    child: ListTile(
                      subtitle: Text(
                          "price: ${snapshot.data!.docs[index]['price']} EGP"),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data!.docs[index]['imageUrl'],
                        ),
                        radius: 16,
                      ),
                      title: Text(
                        snapshot.data!.docs[index]['title'],
                      ),
                      trailing: Text(
                        snapshot.data!.docs[index]['name'],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
