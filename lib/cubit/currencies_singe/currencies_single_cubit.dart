import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:my_utils/check_remote_data.dart';
import 'package:package_example/data/models/currencies_model.dart';
import 'package:package_example/data/network_response.dart';
import 'package:package_example/data/repositories/currencies_repository/currencies_repository.dart';

part 'currencies_single_state.dart';

class CurrenciesSingleCubit extends Cubit<CurrenciesSingleInitial> {
  CurrenciesSingleCubit() : super(CurrenciesSingleInitial.initial());

  Future<void> getCurrencies() async {
    emit(state.copyWith(isLoading: true));
    final NetworkResponse data = await CurrenciesRepository.getCurrencies();
    try {
      if (data.errorMessage.isEmpty) {
        List<CurrenciesModel> currencies = (data.data as List)
            .map((e) => CurrenciesModel.fromJson(e))
            .toList();
        String remoteData = jsonEncode(currencies);
        Checker.checkRemoteData(remoteData: remoteData);
        emit(state.copyWith(isLoading: false, currencies: currencies));
      }
    } catch (e) {
      emit(
          state.copyWith(isLoading: false, error: e.toString(), isError: true));
    }
  }

  void getCurrenciesLocal() {
    emit(state.copyWith(isLoading: true));
    String localData = Checker.getLocalData();
    if (localData.isNotEmpty) {
      List<CurrenciesModel> currencies = (jsonDecode(localData) as List)
          .map((e) => CurrenciesModel.fromJson(e))
          .toList();
      emit(state.copyWith(isLoading: false, currencies: currencies));
    } else {
      emit(state.copyWith(isError: true, error: "No local Data"));
    }
  }
}
