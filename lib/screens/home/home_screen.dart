import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_example/screens/currency_multi_state/currency_multi_state_screen.dart';
import 'package:package_example/screens/currency_single/currency_single_state_screen.dart';
import 'package:package_example/screens/currency_with_bloc/currency_with_bloc_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => const CurrencyWithBloc()));
              },
              child: const Text("Currency Bloc",
                  style: TextStyle(color: Colors.black, fontSize: 32)),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => const CurrencyMultiStateScreen()),
                );
              },
              child: const Text("Currency multi state",
                  style: TextStyle(color: Colors.black, fontSize: 32)),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => const CurrencySingleStateScreen()),
                );
              },
              child: const Text(
                "Currency single state",
                style: TextStyle(color: Colors.black, fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
