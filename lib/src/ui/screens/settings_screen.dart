import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_block.dart';
import 'package:exchange_app/src/blocs/theme/theme_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_state.dart';
import 'package:exchange_app/src/ui/screens/about_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: const Icon(Icons.mode_night_outlined),
            title: const Text("Night Mode"),
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
              context
                  .read<ExchangeRateBloc>()
                  .add(LaunchTelegram());
            },
            leading: const Icon(Icons.telegram),
            title: const Text("Complaints and Suggestions"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ExchangeRateBloc>()
                  .add(CallNumber(callNumber: "+998900144173"));
            },
            leading: const Icon(Icons.phone),
            title: const Text("Call Us"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () async {
              ListTile(
                onTap: () {
                  context.read<ExchangeRateBloc>().add(
                        ShareApp(
                            urlAddress:
                                'https://your-app-url.com'), // Replace with your app's actual URL
                      );
                },
                leading: const Icon(Icons.share),
                title: const Text("Share with friends"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              );
            },
            leading: const Icon(Icons.share),
            title: const Text("Share with friends"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              // BlocProvider.of<ExchangeRateBloc>(context).add(AboutUsViewed());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutAppScreen()),
              );
            },
            leading: const Icon(Icons.transform_sharp),
            title: const Text("About the App"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
