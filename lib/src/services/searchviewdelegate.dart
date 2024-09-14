import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil package
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/screens/converting_screen.dart';

class ExchangeSearchDelegate extends SearchDelegate<Exchange?> {
  final List<Exchange> exchanges;

  ExchangeSearchDelegate(this.exchanges);

  static const Map<String, String> flagsMap = {
    "USD": 'assets/images/usd.png',
    "AED": 'assets/images/aed.png',
    "AUD": 'assets/images/aud.png',
    "CAD": 'assets/images/cad.png',
    "CHF": 'assets/images/chf.png',
    "CNY": 'assets/images/cny.png',
    "DKK": 'assets/images/dkk.png',
    "EGP": 'assets/images/egp.png',
    "EUR": 'assets/images/eur.png',
    "GBP": 'assets/images/gbp.png',
    "ISK": 'assets/images/isk.png',
    "JPY": 'assets/images/jpy.png',
    "KRW": 'assets/images/krw.png',
    "KWD": 'assets/images/kwd.png',
    "KZT": 'assets/images/kzt.png',
    "LBP": 'assets/images/lbp.png',
    "MYR": 'assets/images/myr.png',
    "NOK": 'assets/images/nok.png',
    "PLN": 'assets/images/pln.png',
    "RUB": 'assets/images/rub.png',
    "SEK": 'assets/images/sek.png',
    "SGD": 'assets/images/sgd.png',
    "TRY": 'assets/images/try.png',
    "UAH": 'assets/images/uah.png',
  };

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 24.sp),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 24.sp), 
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = exchanges.where((exchange) {
      final codeLower = exchange.code.toLowerCase();
      final queryLower = query.toLowerCase();
      return codeLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final exchange = suggestions[index];
        return ListTile(
          title: Text(exchange.code,
              style:
                  TextStyle(fontSize: 18.sp)), 
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sell: ${exchange.sell ?? "no_data"}, Buy: ${exchange.buy ?? "no_data"}, Central Bank: ${exchange.price}',
                style:
                    TextStyle(fontSize: 14.sp), 
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConvertingScreen(
                  exchange: exchange,
                  imagePath:
                      flagsMap[exchange.code] ?? 'assets/images/default.png',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = exchanges.where((exchange) {
      final codeLower = exchange.code.toLowerCase();
      final queryLower = query.toLowerCase();
      return codeLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final exchange = suggestions[index];
        return ListTile(
          leading: Container(
            height: 60.h, 
            width: 60.w, 
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10.r), 
            ),
            child: Image.asset(
              flagsMap[exchange.code] ?? 'assets/images/default.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(exchange.code,
              style:
                  TextStyle(fontSize: 16.sp)), 
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.tr("central_bank")}: ${exchange.price}${context.tr("sum")}',
                style:
                    TextStyle(fontSize: 14.sp), 
              ),
              Text(
                '${context.tr("sell")}: ${exchange.sell ?? context.tr("no_data")}',
                style:
                    TextStyle(fontSize: 14.sp), 
              ),
              Text(
                '${context.tr("buy")}: ${exchange.buy ?? context.tr("no_data")}',
                style:
                    TextStyle(fontSize: 14.sp), 
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConvertingScreen(
                  exchange: exchange,
                  imagePath:
                      flagsMap[exchange.code] ?? 'assets/images/default.png',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
