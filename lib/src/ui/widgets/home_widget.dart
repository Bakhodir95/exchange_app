import 'package:exchange_app/src/models/exchange.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final Exchange exchange;

  HomeWidget({super.key, required this.exchange});

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.yellow, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              flagsMap[exchange.code] ?? 'assets/images/default.png',
              height: 50,
              width: 100,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${exchange.title} = CB ${exchange.price.toString()} sum"),
                  Text("Sell: ${exchange.sell ?? "Unknown"}"),
                  Text("Buy: ${exchange.buy ?? "Unknown"}"),
                  Text("Created at: ${exchange.date}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
