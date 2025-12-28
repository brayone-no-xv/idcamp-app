import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 24),
              _buildStats(context),
              const SizedBox(height: 24),
              _buildMenuList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'), // Placeholder
        ),
        const SizedBox(height: 16),
        Text(
          'John Doe',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'john.doe@example.com',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

    Widget _buildStats(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.spaceAround,
      children: [
        _buildStatCard(context, 'Projects', '12', Icons.folder),
        _buildStatCard(context, 'Tasks', '34', Icons.check_circle),
        _buildStatCard(context, 'Teams', '5', Icons.group),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }


  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        _buildMenuListItem(context, 'Edit Profile', Icons.edit, () {}),
        _buildMenuListItem(context, 'Notifications', Icons.notifications, () {}),
        _buildMenuListItem(context, 'Privacy Settings', Icons.security, () {}),
        _buildMenuListItem(context, 'Help & Support', Icons.help, () {}),
        const Divider(),
        _buildMenuListItem(context, 'Logout', Icons.logout, () {}, color: Colors.red),
      ],
    );
  }

  Widget _buildMenuListItem(BuildContext context, String title, IconData icon, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
