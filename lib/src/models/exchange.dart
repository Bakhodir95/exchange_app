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
      buy: map['buy'] != null ? (map['buy'] as num).toDouble() : null,
      sell: map['sell'] != null ? (map['sell'] as num).toDouble() : null,
      price: (map['price'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'code': code,
      'price': price,
      'buy': buy,
      'sell': sell,
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