import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.amber,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
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
                onTap: () {},
                leading: const Icon(Icons.mode_night_outlined),
                title: const Text("Night Mode"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.telegram),
                title: const Text("Complaints and Suggestions"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.phone_android_rounded),
                title: const Text("Contact"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Share.share(
                    'Check out this cool app!',
                    subject: 'Sharing from my Echange Rate',
                  );
                },
                leading: const Icon(Icons.share),
                title: const Text("Share with friends"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text("Settings Screen Content"),
      ),
    );
  }
}
