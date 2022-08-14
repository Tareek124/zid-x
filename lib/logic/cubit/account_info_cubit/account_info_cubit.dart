import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/account_model.dart';

import '../../utils/functions/get_account_info.dart';

part 'account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState?> {
  AccountInfoCubit() : super(null);

  AccountModel? accountModel;

  Future<AccountModel> getUserInfos() async {
    try {
      await getUserDetails().then((data) {
        accountModel = data;
        emit(AccountInfoLoaded(accountModel: data));
      });
    } catch (e) {
      print(e);
      emit(AccountInfoError(error: e.toString()));
    }
    return accountModel!;
  }
}
