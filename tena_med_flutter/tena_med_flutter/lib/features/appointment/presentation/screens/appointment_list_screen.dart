import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  int selectedTab = 0; // For the top tabs
  int selectedBottomNavIndex = 1; // For bottom navigation bar

  final List<String> tabs = ['Scheduled', 'Missed', 'Cancelled', 'Past'];

  final List<Map<String, String>> sampleAppointments = [
    {
      'image': 'assets/images/doctor_avatar.png',
      'name': 'Dr. Dagmawi Samuel',
      'specialty': 'Dentist',
      'time': '02:00 PM'
    },
    {
      'image': 'assets/images/doc1.jpg',
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'time': '10:30 AM'
    },

    // Add more as needed...
  ];

  String searchQuery = '';
  String? selectedCategory;

  void onTabSelected(int index) {
    setState(() {
      selectedBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/post-booking-home'); // Update with your home route
        break;
      case 1:
        context.go('/appointment-list');
        break;
      case 2:
        context.go('/patient_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottomNavIndex,
        onTap: onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Appointments',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedTab == index;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isSelected ? const Color(0xFF00BCD4) : Colors.grey[300],
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 12),

            // Header row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/appointments');
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Color(0xFF00BCD4)),
                    ),
                  ),
                ],
              ),
            ),

            // Appointment List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: sampleAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = sampleAppointments[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppointmentCard(appointment: appointment),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Map<String, String> appointment;

  const AppointmentCard({required this.appointment, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF00BCD4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    appointment['image'] ?? 'assets/images/doc1.jpg',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      appointment['specialty'] ?? '',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text(
                  appointment['time'] ?? '',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
