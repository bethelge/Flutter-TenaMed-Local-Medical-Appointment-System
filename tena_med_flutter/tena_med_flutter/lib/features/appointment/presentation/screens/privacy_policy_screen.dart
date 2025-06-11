import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
We respect your privacy and are committed to protecting your data.

• We do not share your personal information with third parties.
• Your data is stored securely and used only for healthcare purposes.
• You may contact us for data access or deletion.

By using this app, you agree to our policy.

Thank you for trusting us.
''',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
