import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_block.dart';
import 'package:exchange_app/src/blocs/theme/theme_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_state.dart';
import 'package:exchange_app/src/ui/screens/about_app_screen.dart';
import 'package:exchange_app/src/ui/widgets/sizes.dart';
import 'package:exchange_app/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = SizeUtils.bodyWidth(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: Theme.of(context).brightness == Brightness.dark
                  ? LinearGradient(
                      colors: AppColors.darkThemeColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: AppColors.lighThemeColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/images/splash.png'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  context.tr("settings"),
                  style: TextStyle(
                    fontSize: screenWidth < 601 ? 24.sp : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(context.tr("languages")),
            leading: const Icon(
              Icons.language,
              color: Color.fromARGB(255, 53, 175, 57),
            ),
            trailing: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10.r),
              dropdownColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blue.shade900
                  : AppColors.lighThemeColors[1],
              value: context.locale.languageCode,
              items: const [
                DropdownMenuItem(
                  value: "uz",
                  child: Text("Uz"),
                ),
                DropdownMenuItem(
                  value: "en",
                  child: Text("En"),
                ),
                DropdownMenuItem(
                  value: "ru",
                  child: Text("Ru"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.setLocale(Locale(value));
                }
              },
            ),
          ),
          ListTile(
            leading: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDarkMode =
                    (state as ThemeInitial).themeMode == ThemeMode.dark;

                return Icon(
                  isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                  color: isDarkMode ? Colors.amber : Colors.orange,
                );
              },
            ),
            title: Text(context.tr("night_mode")),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDarkMode =
                    (state as ThemeInitial).themeMode == ThemeMode.dark;
                return Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    context
                        .read<ThemeBloc>()
                        .add(ToggleTheme(isDarkMode: value));
                  },
                );
              },
            ),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse('https://t.me/bakhodir1995'));
            },
            leading: const Icon(
              Icons.telegram,
              color: Colors.blue,
            ),
            title: Text("complains_and_suggestions".tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ExchangeRateBloc>()
                  .add(CallNumber(callNumber: "+998900144173"));
            },
            leading: const Icon(
              Icons.phone,
              color: Colors.blue,
            ),
            title: Text("call_us".tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          // ListTile(
          //   onTap: () {
          //     context
          //         .read<ExchangeRateBloc>()
          //         .add(ShareApp(urlAddress: 'https://currency_exchange.com'));
          //   },
          //   leading: const Icon(Icons.share),
          //   title: Text("share_with_friends".tr()),
          //   trailing: const Icon(Icons.arrow_forward_ios_rounded),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
            leading: const Icon(
              Icons.info_outline,
              color: Colors.yellow,
            ),
            title: Text("about_the_app".tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
