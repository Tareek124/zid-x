import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostAdModel extends Equatable {
  final String title;
  final String imageUrl;
  final String id;
  final String description;
  final String uid;
  final String phoneNumber;
  final String name;
  final String price;
  final time;

  const PostAdModel({
    required this.title,
    required this.name,
    required this.price,
    required this.phoneNumber,
    required this.id,
    required this.time,
    required this.uid,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "phonenumber": phoneNumber,
        "name": name,
        'uid': uid,
        "price": price,
        'time': time,
        "description": description,
        "imageUrl": imageUrl,
      };

  factory PostAdModel.fromDocSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostAdModel(
      title: snapshot['title'],
      id: snapshot['id'],
      price: snapshot['price'],
      name: snapshot['name'],
      phoneNumber: snapshot["phonenumber"],
      uid: snapshot['uid'],
      time: snapshot['time'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      id,
      phoneNumber,
      name,
      description,
      imageUrl,
      uid,
      price,
      time,
    ];
  }
}
