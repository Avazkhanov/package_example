import 'package:package_example/data/api_provider/api_provider.dart';
import 'package:package_example/data/network_response.dart';

class CurrenciesRepository {
  static Future<NetworkResponse> getCurrencies() async {
    return await ApiProvider.getCurrencies();
  }
}
