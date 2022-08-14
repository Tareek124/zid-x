import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/account_model.dart';
import '../../../data/post_ad_model.dart';
import 'get_user_id.dart';

Future<AccountModel> getUserDetails() async {
  FirebaseFirestore store = FirebaseFirestore.instance;

  DocumentSnapshot snapshot =
      await store.collection("account").doc(getUserId()).get();

  return AccountModel.fromDocSnapshot(snapshot);
}

//getPostDetails------------------------------------//
Future<PostAdModel> getPostDetails(String id) async {
  FirebaseFirestore store = FirebaseFirestore.instance;

  DocumentSnapshot snapshot = await store.collection("posts").doc(id).get();

  return PostAdModel.fromDocSnapshot(snapshot);
}
