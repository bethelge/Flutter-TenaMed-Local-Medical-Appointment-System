import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),

            // 🔵 User initials circle
            Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF58CFFD),
              ),
              alignment: Alignment.center,
              child: const Text(
                "ET",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 👤 User name
            const Text(
              "Eldana Tasew",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            // ⚙️ Settings options
            SettingsOption(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                context.go('/settings');
              },
            ),
            const Divider(),
            SettingsOption(
              icon: Icons.security,
              title: "License and Privacy Policy",
              onTap: () {
                context.go('/privacy-policy');
              },
            ),
            const Divider(),
            SettingsOption(
              icon: Icons.logout,
              title: "Logout",
              iconColor: Color(0xFF58CFFD),
              onTap: () {
                context.go('/');
              },
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;

  const SettingsOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = const Color(0xFF58CFFD),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.calendar_today), label: "Appointments"),
        NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        if (index == selectedIndex) return;

        if (index == 0) {
          context.go("/post-booking-home");
        } else if (index == 1) {
          context.go("/appointment-list");
        } else if (index == 2) {
          context.go("/patient_profile");
        }
      },

    );
  }
}
