import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Account'),
          _buildSettingsItem(context, 'Edit Profile', Icons.person, () {}),
          _buildSettingsItem(context, 'Change Password', Icons.lock, () {}),
          _buildSettingsItem(context, 'Privacy', Icons.shield, () {}),
          const Divider(),
          _buildSectionHeader(context, 'General'),
          _buildSettingsItem(context, 'Notifications', Icons.notifications, () {}),
          _buildSettingsItem(context, 'Language', Icons.language, () {}),
          _buildSettingsItem(context, 'Help & Support', Icons.help, () {}),
          _buildSettingsItem(context, 'About', Icons.info, () {}),
          const Divider(),
          _buildSettingsItem(context, 'Logout', Icons.exit_to_app, () {}, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title, IconData icon, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
