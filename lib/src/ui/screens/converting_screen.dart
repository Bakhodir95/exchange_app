import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:flutter/material.dart';

class ConvertingScreen extends StatefulWidget {
  final Exchange exchange;
  final String imagePath;

  const ConvertingScreen(
      {super.key, required this.exchange, required this.imagePath});

  @override
  State<ConvertingScreen> createState() => _ConvertingScreenState();
}

class _ConvertingScreenState extends State<ConvertingScreen> {
  final rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double convertedAmountSell = 0;
  double convertedAmountBuy = 0;
  bool isSellPressed = false;
  bool isBuyPressed = false;

  void _sell() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        convertedAmountSell = double.parse(rateController.text) *
            double.parse(widget.exchange.buy.toString());
        rateController.clear();
        isSellPressed = true;
        isBuyPressed = false;
      });
    }
  }

  void _buy() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        convertedAmountBuy = double.parse(rateController.text) *
            double.parse(widget.exchange.sell.toString());
        rateController.clear();
        isBuyPressed = true;
        isSellPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "convert_currency".tr(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(widget.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: context.tr('enter_amount'),
                          prefixIcon: const Icon(Icons.edit_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.tr('please_enter_an_amount');
                          }
                          if (double.tryParse(value) == null) {
                            return context.tr('please_enter_a_valid_number');
                          }
                          if (double.parse(value) <= 0) {
                            return context.tr('please_enter_a_positive_number');
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ElevatedButton(
                            onPressed: _buy,
                            child: Text(
                              context.tr("buy"),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ElevatedButton(
                            onPressed: _sell,
                            child: Text(
                              context.tr("sell"),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        isSellPressed
                            ? "${context.tr('converted_amount', args: [
                                    convertedAmountSell.toStringAsFixed(2)
                                  ])} ${context.tr('sum')}"
                            : isBuyPressed
                                ? "${context.tr('converted_amount', args: [
                                        convertedAmountBuy.toStringAsFixed(2)
                                      ])} ${context.tr('sum')}"
                                : "${context.tr('converted_amount', args: [
                                        '0.00'
                                      ])} ${context.tr('sum')}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/uzb.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
