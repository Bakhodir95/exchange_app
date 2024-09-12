import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("about_the_app")),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
                "Our Currency Rate App is a handy tool that helps you check the latest exchange rates for different currencies around the world. Whether you're planning a trip, shopping online, or just curious about how much your money is worth in another country, this app makes it easy to stay updated.With the Currency Rate App, you can:Get Real-Time Rates: See the most current exchange rates for various currencies.Quick Currency Conversion: Easily convert amounts between different currencies with just a few taps.Save Favorite Currencies: Keep track of the currencies you use most often for quick access.The app is designed to be simple and easy to use, so you can find the information you need without any hassle. Stay informed and make smarter decisions when dealing with foreign currencies, all from your smartphone!"),
          ],
        ),
      ),
    );
  }
}
