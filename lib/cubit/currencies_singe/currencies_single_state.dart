part of 'currencies_single_cubit.dart';

class CurrenciesSingleInitial {
  final bool isLoading;
  final List<CurrenciesModel> currencies;
  final String error;
  final bool isError;

  const CurrenciesSingleInitial({
    required this.isLoading,
    required this.currencies,
    required this.error,
    required this.isError,
  });

  CurrenciesSingleInitial copyWith({
    bool? isLoading,
    List<CurrenciesModel>? currencies,
    String? error,
    bool? isError,
  }) {
    return CurrenciesSingleInitial(
      isLoading: isLoading ?? this.isLoading,
      currencies: currencies ?? this.currencies,
      error: error ?? this.error,
      isError: isError ?? this.isError,
    );
  }

  factory CurrenciesSingleInitial.initial() {
    return const CurrenciesSingleInitial(
      isLoading: false,
      currencies: [],
      error: '',
      isError: false,
    );
  }
}
