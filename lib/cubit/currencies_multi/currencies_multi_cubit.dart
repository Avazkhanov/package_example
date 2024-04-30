import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:my_utils/check_remote_data.dart';
import 'package:package_example/data/models/currencies_model.dart';
import 'package:package_example/data/network_response.dart';
import 'package:package_example/data/repositories/currencies_repository/currencies_repository.dart';

part 'currencies_multi_state.dart';

class CurrenciesMultiCubit extends Cubit<CurrenciesMultiState> {
  CurrenciesMultiCubit() : super(CurrenciesMultiInitial());

  Future<void> getCurrencies() async {
    emit(CurrenciesMultiLoading());
    final NetworkResponse data = await CurrenciesRepository.getCurrencies();
    try {
      if (data.errorMessage.isEmpty) {
        List<CurrenciesModel> currencies = (data.data as List)
            .map((e) => CurrenciesModel.fromJson(e))
            .toList();
        String remoteData = jsonEncode(currencies);
        Checker.checkRemoteData(remoteData: remoteData);
        emit(CurrenciesMultiLoaded(currencies: currencies));
      }
    } catch (e) {
      emit(CurrenciesMultiError(message: e.toString()));
    }
  }

  void getCurrenciesLocal() {
    emit(CurrenciesMultiLoading());
    String localData = Checker.getLocalData();
    if (localData.isNotEmpty) {
      List<CurrenciesModel> currencies = (jsonDecode(localData) as List)
          .map((e) => CurrenciesModel.fromJson(e))
          .toList();
      emit(CurrenciesMultiLoaded(currencies: currencies));
    } else {
      emit(CurrenciesMultiError(message: "No local data"));
    }
  }
}
