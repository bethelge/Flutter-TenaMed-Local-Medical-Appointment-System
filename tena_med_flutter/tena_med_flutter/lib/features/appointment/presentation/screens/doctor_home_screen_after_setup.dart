import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHomeScreenAfterSetup extends StatelessWidget {
  const DoctorHomeScreenAfterSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyAppointments = [
      {
        'patientName': 'Abel Tesfaye',
        'time': 'April 30, 10:00 AM',
        'status': 'Confirmed',
      },
      {
        'patientName': 'Sara Hailu',
        'time': 'April 30, 11:30 AM',
        'status': 'Pending',
      },
      {
        'patientName': 'Miki Girma',
        'time': 'May 1, 9:00 AM',
        'status': 'Confirmed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Appointments"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Home is selected
        onTap: (index) {
          switch (index) {
            case 0:
            // Already on Home, do nothing or refresh
              break;
            case 1:
              context.go('/doctor_profile_after_setup'); // navigate to profile
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: dummyAppointments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final appointment = dummyAppointments[index];
            return AppointmentCard(
              patientName: appointment['patientName']!,
              time: appointment['time']!,
              status: appointment['status']!,
              onDetailsTap: () {
                context.go('/doctor_appointment_detail');
              },
            );
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String status;
  final VoidCallback onDetailsTap;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.status,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patientName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/doctor_appointment_detail');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Appointment Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
