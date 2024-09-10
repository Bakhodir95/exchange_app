import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Icon(Icons.language),
                Text("Language"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.mode_night_outlined),
                Text("Night Mode"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.telegram),
                Text("Complains and Suggestions"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.phone_android_rounded),
                Text("Contact"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                Text("Logout"),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
