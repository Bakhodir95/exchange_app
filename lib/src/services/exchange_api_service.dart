import 'package:dio/dio.dart';
import 'package:exchange_app/src/models/exchange.dart';

class ExchangeApiService {
  final dio = Dio();
  List<Exchange> exchanges = [];

  Future<List<Exchange>> getExchangeRates() async {
    try {
      final response = await dio.get("https://nbu.uz/en/exchange-rates/json/");
      final datas = response.data as List;
      for (var element in datas) {
        exchanges.add(
          Exchange.fromMap(
            element,
          ),
        );
      }
      return exchanges;
    } on DioException catch (e) {
      print(e.error);
      return [];
    } catch (e) {
      print('Error fetching exchange rates: $e');
      return [];
    }
  }
}
