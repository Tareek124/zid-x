import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../data/account_model.dart';
import '../../utils/functions/get_user_id.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState?> {
  AccountCubit() : super(null);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createAccount({
    required String name,
    required String phoneNumber,
    required String about,
    required String profileImage,
  }) async {
    emit(AccountLoading());

    final model = AccountModel(
        userName: name,
        uid: getUserId(),
        profileImage: profileImage,
        phoneNumber: phoneNumber,
        aboutYourSelf: about);
    try {
      await firestore
          .collection("account")
          .doc(getUserId())
          .set(model.toJson())
          .whenComplete(() => emit(AccountSuccess()));
    } catch (e) {
      emit(AccountError(error: e.toString()));
    }
  }
}
