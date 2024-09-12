import 'package:flutter/material.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/screens/converting_screen.dart'; // Import your screen

class ExchangeSearchDelegate extends SearchDelegate<Exchange?> {
  final List<Exchange> exchanges;

  ExchangeSearchDelegate(this.exchanges);
  Map<String, dynamic> flagsMap = {
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
    // Actions for the search bar (e.g., clear button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
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
          trailing: Image.asset(
            flagsMap[exchange.code] ?? 'assets/images/default.png',
            height: 200,
            width: MediaQuery.of(context).size.width / 3,
          ),
          title: Text(exchange.code),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sell: ${exchange.sell}, Buy: ${exchange.buy}, Central Bank: ${exchange.price}',
              ),
            ],
          ),
          onTap: () {
            // Close the search and navigate to the ConvertingScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConvertingScreen(
                  exchange: exchange,
                  imagePath: flagsMap[exchange.code],
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
          title: Text(exchange.code),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sell: ${exchange.sell}, Buy: ${exchange.buy}, Central Bank: ${exchange.price}',
              ),
            ],
          ),
          onTap: () {
            // Close the search and navigate to the ConvertingScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConvertingScreen(
                  exchange: exchange,
                  imagePath: flagsMap[exchange.code],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
