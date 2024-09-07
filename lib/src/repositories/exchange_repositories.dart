import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';

class ExchangeRateRepository {
  final ExchangeApiService apiService;

  ExchangeRateRepository({required this.apiService});

  Future<List<Exchange>> fetchExchangeRates() async {
    return await apiService.getExchangeRates();
  }
}
