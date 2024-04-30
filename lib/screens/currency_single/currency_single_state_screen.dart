import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_state.dart';
import 'package:package_example/cubit/currencies_singe/currencies_single_cubit.dart';
import 'package:package_example/data/models/currencies_model.dart';

class CurrencySingleStateScreen extends StatefulWidget {
  const CurrencySingleStateScreen({super.key});

  @override
  State<CurrencySingleStateScreen> createState() =>
      _CurrencySingleStateScreenState();
}

class _CurrencySingleStateScreenState extends State<CurrencySingleStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cubit Single State Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CurrenciesSingleCubit, CurrenciesSingleInitial>(
              builder: (BuildContext context,  state) {
                if (state.isError) {
                  return Center(child: Text(state.error));
                }

                if (state.error.isEmpty && !state.isLoading) {
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

                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (!state.hasInternet) {
                context.read<CurrenciesSingleCubit>().getCurrenciesLocal();
              } else {
                context.read<CurrenciesSingleCubit>().getCurrencies();
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}