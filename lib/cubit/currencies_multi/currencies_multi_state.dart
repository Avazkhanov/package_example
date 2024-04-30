part of 'currencies_multi_cubit.dart';

abstract class CurrenciesMultiState {}

class CurrenciesMultiInitial extends CurrenciesMultiState {}

class CurrenciesMultiLoading extends CurrenciesMultiState {}

class CurrenciesMultiLoaded extends CurrenciesMultiState {
  final List<CurrenciesModel> currencies;

  CurrenciesMultiLoaded({required this.currencies});
}

class CurrenciesMultiError extends CurrenciesMultiState {
  final String message;

  CurrenciesMultiError({required this.message});
}
