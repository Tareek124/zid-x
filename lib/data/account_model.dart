// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel extends Equatable {
  final String userName;
  final String phoneNumber;
  final String uid;
  final String profileImage;
  final String aboutYourSelf;

  const AccountModel({
    required this.userName,
    required this.profileImage,
    required this.uid,
    required this.phoneNumber,
    required this.aboutYourSelf,
  });

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "about": aboutYourSelf,
        "phonenumber": phoneNumber,
        "profileimage": profileImage,
      };

  factory AccountModel.fromDocSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AccountModel(
      userName: snapshot['username'],
      uid: snapshot['uid'],
      profileImage: snapshot['profileimage'],
      aboutYourSelf: snapshot['about'],
      phoneNumber: snapshot['phonenumber'],
    );
  }

  @override
  List<Object> get props {
    return [userName, uid, aboutYourSelf, phoneNumber, profileImage];
  }
}
