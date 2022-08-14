import 'package:firebase_auth/firebase_auth.dart';

String getUserId() {
  FirebaseAuth user = FirebaseAuth.instance;
  return user.currentUser!.uid;
}
