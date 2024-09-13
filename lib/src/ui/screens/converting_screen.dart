import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/extentions/mediaquery.dart';
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
          style: TextStyle(
              fontSize: context.responsiveFontSize(25), 
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15), 
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
                          horizontal: 15, vertical: 10), 
                      child: Container(
                        width: double.infinity,
                        height: context.screenHeight /
                            4, 
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'enter_amount'.tr(),
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
                              horizontal: 10, vertical: 10), 
                          child: ElevatedButton(
                            onPressed: _buy,
                            child: Text(
                              "buy".tr(),
                              style: TextStyle(
                                fontSize: context.responsiveFontSize(
                                    18), 
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10), 
                          child: ElevatedButton(
                            onPressed: _sell,
                            child: Text(
                              "sell".tr(),
                              style: TextStyle(
                                fontSize: context.responsiveFontSize(
                                    18), 
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 144, 240, 147),
                        ),
                        child: Text(
                          widget.exchange.buy != null
                              ? isSellPressed
                                  ? "${context.tr('converted_amount')}: \n${convertedAmountSell.toStringAsFixed(2)} ${context.tr('sum')}"
                                  : isBuyPressed
                                      ? "${context.tr('converted_amount')}: \n${convertedAmountBuy.toStringAsFixed(2)} ${context.tr('sum')}"
                                      : "${context.tr('converted_amount')}: 0.00 ${context.tr('sum')}"
                              : context.tr("no_data"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context
                                .responsiveFontSize(22), 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10), 
                      child: Container(
                        width: double.infinity,
                        height: context.screenHeight / 4, 
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
