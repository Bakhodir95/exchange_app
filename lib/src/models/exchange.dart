import 'dart:ffi';

import 'package:exchange_app/src/utils/extentions.dart';

class Exchange {
  String title;
  String code;
  double price;
  double? buy;
  double? sell;
  DateTime date;

  Exchange({
    required this.title,
    required this.code,
    this.buy,
    this.sell,
    required this.price,
    required this.date,
  });

  factory Exchange.fromMap(Map<String, dynamic> map) {
    return Exchange(
        title: map['title'] as String,
        code: map['code'] as String,
        buy: map['nbu_buy_price'] != null
            ? double.parse(map["nbu_buy_price"])
            : null,
        sell: map['nbu_cell_price'] != null
            ? double.parse(map["nbu_cell_price"])
            : null,
        price: double.parse(map["cb_price"]),
        date: map['date'].toString().toCustomDateTime()!);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'code': code,
      'cb_price': price,
      'nbu_buy_price': buy,
      'nbu_cell_price': sell,
      'date': date.toIso8601String(),
    };
  }
}

  // "title": "UAE Dirham",
  //   "code": "AED",
  //   "cb_price": "3459.92",
  //   "nbu_buy_price": null,
  //   "nbu_cell_price": null,
  //   "date": "09/07/2024 11:00:01 am"