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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(context.tr("currency_rate_app_description")),
          ],
        ),
      ),
    );
  }
}
