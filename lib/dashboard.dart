import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/main.dart';
import 'package:myapp/detail.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Back!',
          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 24),
              _buildStatsCards(context),
              const SizedBox(height: 24),
              _buildChart(context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildSocialButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            Tooltip(
              message: 'Filter',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              ),
            ),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              controller.closeView(item);
            },
          );
        });
      },
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.spaceAround,
      children: [
        _buildStatCard(context, 'Followers', '1,234', Icons.people),
        _buildStatCard(context, 'Likes', '5,678', Icons.favorite),
        _buildStatCard(context, 'Posts', '345', Icons.article),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
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

  Widget _buildChart(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(1, 4),
                        FlSpot(2, 3.5),
                        FlSpot(3, 5),
                        FlSpot(4, 4.5),
                        FlSpot(5, 6),
                      ],
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialButton(
            icon: FontAwesomeIcons.twitter,
            onPressed: () => _showFeatureNotAvailable(context, "Twitter"),
            color: const Color(0xFF1DA1F2),
          ),
          const SizedBox(width: 16),
          _buildSocialButton(
            icon: FontAwesomeIcons.facebook,
            onPressed: () => _showFeatureNotAvailable(context, "Facebook"),
            color: const Color(0xFF1877F2),
          ),
          const SizedBox(width: 16),
          _buildSocialButton(
            icon: FontAwesomeIcons.instagram,
            onPressed: () => _showFeatureNotAvailable(context, "Instagram"),
            color: const Color(0xFFE4405F),
          ),
          const SizedBox(width: 16),
          _buildSocialButton(
            icon: FontAwesomeIcons.linkedin,
            onPressed: () => _showFeatureNotAvailable(context, "LinkedIn"),
            color: const Color(0xFF0A66C2),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickActionButton(
                    context,
                    'Profile',
                    Icons.person,
                    Colors.green,
                    () {
                      Navigator.pushNamed(context, '/profile');
                      _showSuccessSnackbar(context, 'Navigating to Profile');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    context,
                    'Gallery',
                    Icons.photo,
                    Colors.purple,
                    () {
                      Navigator.pushNamed(context, '/gallery');
                      _showSuccessSnackbar(context, 'Opening Gallery');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    context,
                    'Notes',
                    Icons.note,
                    Colors.teal,
                    () {
                      Navigator.pushNamed(context, '/notes');
                      _showSuccessSnackbar(context, 'Opening Notes');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    context,
                    'Settings',
                    Icons.settings,
                    Colors.orange,
                    () {
                      Navigator.pushNamed(context, '/settings');
                      _showSuccessSnackbar(context, 'Opening Settings');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    context,
                    'Detail',
                    Icons.info_outline,
                    Colors.indigo,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailScreen(
                            title: 'Dashboard Detail',
                            description:
                                'This is a detail page navigated from Dashboard using Navigator.push() with parameters.',
                            icon: Icons.dashboard,
                            color: Colors.blue,
                          ),
                        ),
                      );
                      _showSuccessSnackbar(context, 'Opening Detail Page');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildQuickActionButton(
                    context,
                    'Home',
                    Icons.home,
                    Colors.red,
                    () => _showConfirmDialog(
                      context,
                      'Go to Home',
                      'Are you sure you want to go back to home screen?',
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show success snackbar
  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Helper method to show feature not available dialog
  void _showFeatureNotAvailable(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600]),
              const SizedBox(width: 8),
              const Text('Info'),
            ],
          ),
          content: Text('$feature feature is not yet available. Coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to show confirmation dialog
  void _showConfirmDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange[600]),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            color: color,
            iconSize: 28,
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: color,
        child: IconButton(
          icon: FaIcon(icon),
          onPressed: onPressed,
          iconSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
