import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/extentions/mediaquery.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/screens/converting_screen.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final Exchange exchange;

  HomeWidget({super.key, required this.exchange});

  static const Map<String, dynamic> flagsMap = {
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ConvertingScreen(
                exchange: exchange,
                imagePath: flagsMap[exchange.code],
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: context.screenHeight / 4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  flagsMap[exchange.code] ?? 'assets/images/default.png',
                  fit: BoxFit.contain,
                  height: context.screenHeight / 5,
                  width: context.screenWidth / 3,
                ),
              ),
              SizedBox(width: context.screenWidth / 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Central Bank \n1 ${exchange.title} = ${(exchange.price)} ${context.tr("sum")}",
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(13),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "${"sell".tr()}: ${(exchange.sell ?? context.tr("no_data"))} ${context.tr("sum")}",
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(13),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${"buy".tr()}: ${(exchange.buy ?? context.tr("no_data"))} ${context.tr("sum")}",
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(13),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${"updated_at".tr()}: ${exchange.date}",
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
