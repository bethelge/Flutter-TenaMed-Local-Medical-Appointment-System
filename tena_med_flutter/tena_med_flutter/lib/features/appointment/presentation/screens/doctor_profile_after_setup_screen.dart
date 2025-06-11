import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorProfileAfterSetupScreen extends StatelessWidget {
  const DoctorProfileAfterSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFFF0F8FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/doctor_avatar.png'), // add a placeholder image here
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Dr. Doc Roc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 4),
                          Text('Optometrist', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('Works at St. Paul', style: TextStyle(fontSize: 14, color: Color(0xFF00BCD4))),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Text('Addis Ababa', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/doctor_profile_setup'); // navigate to profile edit screen
                      },
                      child: const Text('Edit', style: TextStyle(color: Color(0xFF00BCD4))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notifications ▼',
                style: TextStyle(color: const Color(0xFF00BCD4), fontSize: 16),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Profile is selected
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/doctor_home_after_setup');
              break;
            case 1:
            // Already on Profile screen
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

    );
  }
}
