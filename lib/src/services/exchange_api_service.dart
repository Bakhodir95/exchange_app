import 'package:dio/dio.dart';
import 'package:exchange_app/src/models/exchange.dart';

class ExchangeApiService {
  final dio = Dio();

  Future<List<Exchange>> getExchangeRates() async {
    try {
      List<Exchange> exchanges = [];
      final response = await dio.get("https://nbu.uz/en/exchange-rates/json/");
      final datas = response.data as List;
      for (var element in datas) {
        exchanges.add(
          Exchange.fromMap(
            element,
          ),
        );
      }
      print(response);
      return exchanges;
    } catch (e) {
      print('Error fetching exchange rates: $e');
      return [];
    }
  }
}
