import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tena_med_flutter/features/appointment/data/models/doctor_card.dart';

class PostBookingHomeScreen extends StatefulWidget {
  const PostBookingHomeScreen({super.key});

  @override
  State<PostBookingHomeScreen> createState() => _PostBookingHomeScreenState();
}

class _PostBookingHomeScreenState extends State<PostBookingHomeScreen> {
  final List<String> categories = [
    "Optometrist",
    "Dentist",
    "Cardiologist",
    "Neurologist",
    "Pediatrician",
    "Dermatologist"
  ];

  final List<DoctorCard> doctors = [
    DoctorCard("Dr. Dagmawi Samuel", "Dentist", 'assets/images/doctor_avatar.png', "Expert in dental health."),
    DoctorCard("Dr. Ezra Melaku", "Cardiologist", 'assets/images/doc1.jpg', "Experienced in cardiovascular medicine."),
    DoctorCard("Dr. Hana Bekele", "Optometrist", 'assets/images/doc2.jpg', "Specializes in vision and eye health."),
  ];


  String searchQuery = '';
  String? selectedCategory;
  int selectedIndex = 0;

  List<DoctorCard> get filteredDoctors {
    return doctors.where((doctor) {
      final query = searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          doctor.name.toLowerCase().contains(query) ||
          doctor.specialization.toLowerCase().contains(query);
      final matchesCategory = selectedCategory == null ||
          doctor.specialization.toLowerCase() == selectedCategory!.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        context.go('/appointment-list');
        break;
      case 2:
        context.go('/patient_profile');
        break;
    }
  }

  void _goToDoctorDetail(DoctorCard doctor) {
    context.go('/doctor-detail', extra: doctor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabSelected,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF00BCD4),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Appointments"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Appointments",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () => context.go('/appointment-list'),
                    child: Text(
                      "See all",
                      style: TextStyle(color: Color(0xFF00BCD4)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () => context.go('/appointment-list'),
                borderRadius: BorderRadius.circular(12),
                child: Card(
                  color: Color(0xFFB2EBF2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/doctor_avatar.png',
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" Dr Dagmawi Samuel",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                Text("Dentist",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[800])),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.access_time, color: Color(0xFF00BCD4)),
                                SizedBox(width: 8),
                                Text("April 25 at 10:00 AM", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: "Let's find your doctor, Name, Specialization",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, index) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = isSelected ? null : category;
                        });
                      },
                      selectedColor: Color(0xFFB2EBF2),
                      backgroundColor: Color(0xFFB2EBF2).withOpacity(0.5),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.black : Colors.black87,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredDoctors.length,
                  separatorBuilder: (_, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doctor = filteredDoctors[index];
                    return GestureDetector(
                      onTap: () => _goToDoctorDetail(doctor),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
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
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doctor.name,
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text(doctor.specialization,
                                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 16),
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
      ),
    );
  }
}

