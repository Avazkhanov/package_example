import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:my_utils/check_remote_data.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_event.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_state.dart';
import 'package:package_example/data/models/currencies_model.dart';
import 'package:package_example/data/network_response.dart';
import 'package:package_example/data/repositories/currencies_repository/currencies_repository.dart';

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  CurrenciesBloc() : super(CurrenciesInitial()) {
    on<GetCurrenciesEvent>(_getCurrencies);
    on<GetCurrenciesLocalEvent>(_getCurrenciesLocal);
  }

  Future<void> _getCurrencies(
      GetCurrenciesEvent event, Emitter<CurrenciesState> emit) async {
    emit(CurrenciesLoading());
    final NetworkResponse data = await CurrenciesRepository.getCurrencies();

    try {
      if (data.errorMessage.isEmpty) {
        List<CurrenciesModel> currencies = (data.data as List)
            .map((e) => CurrenciesModel.fromJson(e))
            .toList();
        String remoteData = jsonEncode(currencies);
        Checker.checkRemoteData(remoteData: remoteData);
        emit(CurrenciesLoaded(currencies: currencies));
      }
    } catch (e) {
      emit(
        CurrenciesError(
          message: data.errorMessage,
        ),
      );
    }
  }

  void _getCurrenciesLocal(
      GetCurrenciesLocalEvent event, Emitter<CurrenciesState> emit) {
    emit(CurrenciesLoading());
    String localData = Checker.getLocalData();
    if (localData.isNotEmpty) {
      List<CurrenciesModel> currencies = (jsonDecode(localData) as List)
          .map((e) => CurrenciesModel.fromJson(e))
          .toList();
      emit(CurrenciesLoaded(currencies: currencies));
    } else {
      emit(CurrenciesError(message: 'No local data'));
    }
  }
}
