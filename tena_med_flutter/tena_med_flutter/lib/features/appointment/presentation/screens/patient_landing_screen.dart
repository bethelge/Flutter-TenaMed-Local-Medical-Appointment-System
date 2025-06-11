import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tena_med_flutter/features/appointment/data/models/doctor_card.dart';

class PatientLandingScreen extends StatefulWidget {
  const PatientLandingScreen({super.key});

  @override
  State<PatientLandingScreen> createState() => _PatientLandingScreenState();
}

class _PatientLandingScreenState extends State<PatientLandingScreen> {
  final List<DoctorCard> doctors = [
    DoctorCard(
      "Dr. Dagmawi Samuel",
      "Pediatrician",
      'assets/images/doctor_avatar.png',
      "Dr. Eleni is a specialist in child healthcare with over 10 years of experience.",
    ),
    DoctorCard(
      "Dr. Natnael Abebe",
      "Neurologist",
      'assets/images/doc2.jpg',
      "Dr. Natnael specializes in nervous system disorders and treatments.",
    ),
  ];

  final List<String> categories = [
    "Optometrist",
    "Dentist",
    "Cardiologist",
    "Neurologist",
    "Pediatrician",
    "Dermatologist",
    "Orthopedic",
    "Psychiatrist",
    "Surgeon",
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          doctor.specialization.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      appBar: AppBar(
        title: const Text('Welcome, Patient!'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: "Let's find your doctor, Name, Specialization",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // 🏷️ Horizontally scrollable categories
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Chip(
                    label: Text(category),
                    backgroundColor: const Color(0xFFB2EBF2),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // 🧑‍⚕️ Doctor cards
            Expanded(
              child: ListView.separated(
                itemCount: filteredDoctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return InkWell(
                    onTap: () => context.go('/doctor-detail', extra: doctor),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                doctor.imagePath,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor.specialization,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.more_vert, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
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
