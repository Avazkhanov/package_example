import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_state.dart';
import 'package:package_example/cubit/currencies_multi/currencies_multi_cubit.dart';
import 'package:package_example/data/models/currencies_model.dart';



class CurrencyMultiStateScreen extends StatefulWidget {
  const CurrencyMultiStateScreen({super.key});

  @override
  State<CurrencyMultiStateScreen> createState() =>
      _CurrencyMultiStateScreenState();
}

class _CurrencyMultiStateScreenState extends State<CurrencyMultiStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cubit Multi State Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CurrenciesMultiCubit, CurrenciesMultiState>(
              builder: (BuildContext context, CurrenciesMultiState state) {
                if (state is CurrenciesMultiError) {
                  return Center(child: Text(state.message));
                }
                if (state is CurrenciesMultiLoaded) {
                  return ListView.builder(
                    itemCount: state.currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      CurrenciesModel currencyModel = state.currencies[index];
                      return ListTile(
                        title: Text(
                          currencyModel.title,
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(currencyModel.cbPrice,
                            style: const TextStyle(fontSize: 18)),
                        trailing: Text(currencyModel.code,
                            style: const TextStyle(fontSize: 16)),
                      );
                    },
                  );
                }
                if (state is CurrenciesMultiLoading) {
                  const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (!state.hasInternet) {
                context.read<CurrenciesMultiCubit>().getCurrenciesLocal();
              } else {
                context.read<CurrenciesMultiCubit>().getCurrencies();
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}