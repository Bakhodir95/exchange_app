import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool isSellSum = false;

  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }

  void _buy() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final rate = double.parse(rateController.text);

        final buyRate = widget.exchange.sell ?? 1;

        convertedAmountBuy = rate * buyRate;

        isBuyConversion = true;
        isSellConversion = false;
        isSellSum = false;
      });
    }
  }

  void _sell() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final rate = double.parse(rateController.text);

        final sellRate = widget.exchange.buy ?? 1;

        convertedAmountSell = rate * sellRate;

        isSellConversion = true;
        isBuyConversion = false;
        isSellSum = false;
      });
    }
  }

  void _sellSum() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final rate = double.parse(rateController.text);

        final buyRate = widget.exchange.buy ?? 1;

        convertedAmountBuy = rate / buyRate;

        isSellSum = true;
        isSellConversion = false;
        isBuyConversion = false;
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          Widget content = Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  screenWidth < 601
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400.w,
                            height: 200.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.imagePath),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                      : flagsDesktop(widget.imagePath),
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
                  SizedBox(height: 15.h),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? LinearGradient(
                                  colors: [Colors.blue, Colors.blue.shade900],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.lightGreenAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                        ),
                        child: Text(
                          "1 ${widget.exchange.title} = ${(widget.exchange.price)} ${context.tr("sum")}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
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
                                    return context
                                        .tr('please_enter_a_valid_number');
                                  }
                                  if (double.parse(value) <= 0) {
                                    return context
                                        .tr('please_enter_a_positive_number');
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: rateController.clear,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.blue.shade900
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            Colors.green,
                                            Colors.lightGreenAccent
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                ),
                                child: Text(
                                  "clear".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          screenWidth < 601 ? 22.sp : 18.sp),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth,
                        // height: screenWidth < 601 ? 100.h : 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? LinearGradient(
                                  colors: [Colors.blue, Colors.blue.shade900],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.lightGreenAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              widget.exchange.buy != null
                                  ? isSellConversion
                                      ? "${context.tr('converted_amount')}: \n${convertedAmountSell.toStringAsFixed(2)} ${context.tr('sum')}"
                                      : isBuyConversion
                                          ? "${context.tr('converted_amount')}: \n${convertedAmountBuy.toStringAsFixed(2)} ${context.tr('sum')}"
                                          : isSellSum
                                              ? "${context.tr('converted_amount')}: \n${convertedAmountBuy.toStringAsFixed(2)} ${widget.exchange.title}"
                                              : "${context.tr('converted_amount')}: 0.00"
                                  : context.tr("no_data"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenWidth < 601 ? 20.sp : 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: _buy,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.blue.shade900
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            Colors.green,
                                            Colors.lightGreenAccent
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                ),
                                child: Text(
                                  "buy".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          screenWidth < 601 ? 22.sp : 13.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: _sell,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.blue.shade900
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Colors.lightGreenAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                  ),
                                  child: Text(
                                    "sell".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth < 601 ? 22.sp : 13.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: _sellSum,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.blue.shade900
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Colors.lightGreenAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                  ),
                                  child: Text(
                                    "sell_sum".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth < 601 ? 18.sp : 13.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          return constraints.maxWidth > 601
              ? SingleChildScrollView(child: content)
              : content;
        },
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
