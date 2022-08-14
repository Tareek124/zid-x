import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../data/post_ad_model.dart';
import '../../utils/functions/get_user_id.dart';
import 'package:uuid/uuid.dart';

import '../../utils/functions/storage_function.dart';

part 'post_ad_state.dart';

class PostAdCubit extends Cubit<PostAdState> {
  PostAdCubit() : super(PostAdInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postAPost({
    required String description,
    required String imageUrl,
    required String uid,
    required String name,
    required String phoneNumber,
    required String title,
    required String price,
  }) async {
    emit(PostAdLoading());

    String id = const Uuid().v1();

    final postModel = PostAdModel(
      name: name,
      price: price,
      phoneNumber: phoneNumber,
      description: description,
      uid: getUserId(),
      time: FieldValue.serverTimestamp(),
      id: id,
      imageUrl: imageUrl,
      title: title,
    );

    try {
      await _firestore.collection("posts").doc(id).set(postModel.toJson());
      emit(PostAdSuccess());
    } catch (e) {
      emit(PostAdError(error: e.toString()));
    }
  }
}
