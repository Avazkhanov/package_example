import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_state.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_event.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_state.dart';
import 'package:package_example/data/models/currencies_model.dart';


class CurrencyWithBloc extends StatefulWidget {
  const CurrencyWithBloc({super.key});

  @override
  State<CurrencyWithBloc> createState() =>
      _CurrencyWithBlocState();
}

class _CurrencyWithBlocState extends State<CurrencyWithBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Currency With Bloc",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CurrenciesBloc, CurrenciesState>(
              builder: (BuildContext context, CurrenciesState state) {
                if (state is CurrenciesError) {
                  return Center(child: Text(state.message));
                }
                if (state is CurrenciesLoaded) {
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
                if(state is CurrenciesLoading){
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
                context.read<CurrenciesBloc>().add(GetCurrenciesLocalEvent());
              } else {
                context.read<CurrenciesBloc>().add(GetCurrenciesEvent());
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}