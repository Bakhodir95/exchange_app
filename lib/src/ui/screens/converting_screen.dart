import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil package

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
  bool isSellConversion = false;
  bool isBuyConversion = false;

  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }

  void _buy() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final rate = double.parse(rateController.text);
        final sellRate = widget.exchange.sell ?? 1;
        convertedAmountSell = rate * sellRate;
        rateController.clear();
        isSellConversion = true;
        isBuyConversion = false;
      });
    }
  }

  void _sell() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final rate = double.parse(rateController.text);
        final buyRate = widget.exchange.buy ?? 1;
        convertedAmountBuy = rate * buyRate;
        rateController.clear();
        isBuyConversion = true;
        isSellConversion = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = SizeUtils.bodyWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "convert_currency".tr(),
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              screenWidth < 601
                  ? Container(
                      width: 400.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : flagsDesktop(widget.imagePath), 
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _buy,
                    child: Text(
                      "buy".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _sell,
                    child: Text(
                      "sell".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: const Color.fromARGB(255, 28, 227, 35),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Text(
                    widget.exchange.buy != null
                        ? isSellConversion
                            ? "${context.tr('converted_amount')}: \n${convertedAmountSell.toStringAsFixed(2)} ${context.tr('sum')}"
                            : isBuyConversion
                                ? "${context.tr('converted_amount')}: \n${convertedAmountBuy.toStringAsFixed(2)} ${context.tr('sum')}"
                                : "${context.tr('converted_amount')}: 0.00 ${context.tr('sum')}"
                        : context.tr("no_data"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 22.sp : 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              screenWidth < 601
                  ? Container(
                      width: 400.w,
                      height: 200.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/uzb.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget flagsDesktop(String imagePath) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
      Container(
        width: 200.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/uzb.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ],
  );
}
