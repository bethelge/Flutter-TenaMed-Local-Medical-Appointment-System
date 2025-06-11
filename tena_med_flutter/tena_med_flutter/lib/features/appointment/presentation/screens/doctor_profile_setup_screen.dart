import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorProfileSetupScreen extends StatefulWidget {
  const DoctorProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileSetupScreen> createState() => _DoctorProfileSetupScreenState();
}

class _DoctorProfileSetupScreenState extends State<DoctorProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedLocation;
  String? selectedSpecialty;
  String? selectedLanguage;
  String? selectedHospital;
  bool acceptedTerms = false;

  final List<String> locations = ['Addis Ababa', 'Gondar', 'Mekelle'];
  final List<String> specialties = ['Cardiology', 'Dermatology', 'Pediatrics'];
  final List<String> languages = ['Amharic', 'English', 'Oromo'];
  final List<String> hospitals = ["St. Paul's", 'Tikur Anbessa', 'Betezata'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome, Dr!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Let's complete your profile so patients can find and book you easily.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                const Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                const SizedBox(height: 16),

                _buildTextField("Full Name", _fullNameController, validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your full name';
                  return null;
                }),
                const SizedBox(height: 8),

                _buildDropdown("Location", locations, selectedLocation, (val) {
                  setState(() => selectedLocation = val);
                }, validator: (val) => val == null ? 'Please select a location' : null),
                const SizedBox(height: 8),

                _buildDropdown("Specialty", specialties, selectedSpecialty, (val) {
                  setState(() => selectedSpecialty = val);
                }, validator: (val) => val == null ? 'Please select a specialty' : null),
                const SizedBox(height: 8),

                _buildTextField(
                  "Years of Experience",
                  _experienceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your experience';
                    if (int.tryParse(value) == null) return 'Enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                _buildDropdown("Languages Spoken", languages, selectedLanguage, (val) {
                  setState(() => selectedLanguage = val);
                }, validator: (val) => val == null ? 'Please select a language' : null),
                const SizedBox(height: 8),

                _buildDropdown("Hospital/Clinic Name", hospitals, selectedHospital, (val) {
                  setState(() => selectedHospital = val);
                }, validator: (val) => val == null ? 'Please select a hospital' : null),
                const SizedBox(height: 8),

                const Icon(Icons.cloud_upload, size: 32, color: Colors.cyan),
                const SizedBox(height: 8),

                _buildTextField(
                  "Short description",
                  _descriptionController,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please write a short description';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Checkbox(
                      value: acceptedTerms,
                      onChanged: (val) {
                        setState(() => acceptedTerms = val ?? false);
                      },
                    ),
                    const Text("I accept the terms"),
                    const SizedBox(width: 4),
                    const Text(
                      "Read our T&Cs",
                      style: TextStyle(color: Colors.cyan, fontSize: 12),
                    ),
                  ],
                ),
                if (!acceptedTerms)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'You must accept the terms to proceed.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown(
      String label,
      List<String> items,
      String? selectedValue,
      ValueChanged<String?> onChanged, {
        String? Function(String?)? validator,
      }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && acceptedTerms) {
      print("Full Name: ${_fullNameController.text}");
      print("Location: $selectedLocation");
      print("Specialty: $selectedSpecialty");
      print("Experience: ${_experienceController.text}");
      print("Language: $selectedLanguage");
      print("Hospital: $selectedHospital");
      print("Description: ${_descriptionController.text}");
      print("Terms accepted: $acceptedTerms");

      // ✅ Navigate using go_router
      context.go('/doctor_profile_after_setup');
    } else if (!acceptedTerms) {
      setState(() {}); // To trigger the error message
    }
  }

}
