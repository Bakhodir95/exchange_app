import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/ui/screens/converting_screen.dart';
import 'package:exchange_app/src/ui/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class HomeWidget extends StatelessWidget {
  final Exchange exchange;

  const HomeWidget({super.key, required this.exchange});

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
    double screenWidth = SizeUtils.bodyWidth(context);
    return Padding(
      padding: EdgeInsets.all(10.w),
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
        child: screenWidth < 800
            ? mobileHomeContainer(context)
            : desktopHomeContainer(context),
      ),
    );
  }

  Widget desktopHomeContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity.w,
      height: double.infinity.h,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(
                  flagsMap[exchange.code] ?? 'assets/images/default.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${context.tr("central_bank")} \n1 ${exchange.title} = ${(exchange.price)} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "${"sell".tr()}: ${(exchange.sell ?? context.tr("no_data"))} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${"buy".tr()}: ${(exchange.buy ?? context.tr("no_data"))} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${"updated_at".tr()}:\n${exchange.date}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mobileHomeContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      height: 300.h,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(
                  flagsMap[exchange.code] ?? 'assets/images/default.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${context.tr("central_bank")}\n1 ${exchange.title} = ${(exchange.price)} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "${"sell".tr()}: ${(exchange.sell ?? context.tr("no_data"))} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "${"buy".tr()}: ${(exchange.buy ?? context.tr("no_data"))} ${context.tr("sum")}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "${"updated_at".tr()}:\n${exchange.date}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
