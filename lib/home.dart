import 'package:flutter/material.dart';
import 'package:myapp/dashboard.dart';
import 'package:myapp/profile.dart';
import 'package:myapp/settings.dart';
import 'package:myapp/login.dart';
import 'package:myapp/gallery.dart';
import 'package:myapp/notes.dart';
import 'package:myapp/about.dart';
import 'package:myapp/status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Camp App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome to ID Camp App!',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Navigate to different screens using the buttons below',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildNavigationCard(
                    context,
                    'Dashboard',
                    Icons.dashboard,
                    Colors.blue,
                    () => Navigator.pushNamed(context, '/dashboard'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Profile',
                    Icons.person,
                    Colors.green,
                    () => Navigator.pushNamed(context, '/profile'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Settings',
                    Icons.settings,
                    Colors.orange,
                    () => Navigator.pushNamed(context, '/settings'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Gallery',
                    Icons.photo_library,
                    Colors.purple,
                    () => Navigator.pushNamed(context, '/gallery'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Notes',
                    Icons.note,
                    Colors.teal,
                    () => Navigator.pushNamed(context, '/notes'),
                  ),
                  _buildNavigationCard(
                    context,
                    'About',
                    Icons.info,
                    Colors.indigo,
                    () => Navigator.pushNamed(context, '/about'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Status',
                    Icons.favorite,
                    Colors.pink,
                    () => Navigator.pushNamed(context, '/status'),
                  ),
                  _buildNavigationCard(
                    context,
                    'Login',
                    Icons.login,
                    Colors.red,
                    () => Navigator.pushNamed(context, '/login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
