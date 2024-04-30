import 'package:package_example/data/models/currencies_model.dart';

abstract class CurrenciesState {}

class CurrenciesInitial extends CurrenciesState {}

class CurrenciesLoading extends CurrenciesState {}

class CurrenciesLoaded extends CurrenciesState {
  final List<CurrenciesModel> currencies;

  CurrenciesLoaded({required this.currencies});
}

class CurrenciesError extends CurrenciesState {
  final String message;

  CurrenciesError({required this.message});
}
