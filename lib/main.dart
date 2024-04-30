import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_utils/storage_repository.dart';
import 'package:package_example/bloc/connectvity/connectivity_bloc.dart';
import 'package:package_example/bloc/connectvity/connectivity_event.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:package_example/bloc/currencies_bloc/currencies_event.dart';
import 'package:package_example/cubit/currencies_multi/currencies_multi_cubit.dart';
import 'package:package_example/cubit/currencies_singe/currencies_single_cubit.dart';
import 'package:package_example/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StorageRepository.instance;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CurrenciesBloc()..add(GetCurrenciesEvent())),
        BlocProvider(create: (_) => CurrenciesSingleCubit()..getCurrencies()),
        BlocProvider(create: (_) => CurrenciesMultiCubit()..getCurrencies()),
        BlocProvider(create: (_) => ConnectivityBloc()..add(CheckConnectivity())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          theme: ThemeData(appBarTheme: const AppBarTheme(backgroundColor: Colors.orange)),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
