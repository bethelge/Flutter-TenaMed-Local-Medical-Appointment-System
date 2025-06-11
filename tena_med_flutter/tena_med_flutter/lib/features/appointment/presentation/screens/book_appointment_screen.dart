import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/appointment_viewmodel.dart';
import '../../domain/entities/appointment.dart';
 // adjust import to your setup

class BookAppointmentScreen extends ConsumerStatefulWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends ConsumerState<BookAppointmentScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController noteController = TextEditingController();
  String? appointmentId;  // Declare appointmentId here

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: now,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  Future<void> _bookAppointment() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    // TODO: Replace these with actual logged-in patient and selected doctor IDs
    final String patientId = '4';
    final String doctorId = '2';
    final String note = noteController.text;

    // Combine date and time into a DateTime object
    final DateTime appointmentDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final appointment = Appointment(
      id: '', // empty or null, backend usually assigns this
      patientId: patientId,
      doctorId: doctorId,
      reason: note,
      date: appointmentDateTime,
    );

    try {
      await ref.read(appointmentViewModelProvider.notifier).bookAppointment(appointment);

      // For now, assign a dummy appointment ID after success
      setState(() {
        appointmentId = 'some-generated-id'; // Update this if your backend returns real ID
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment booked with ID: $appointmentId')),
        );
        context.go('/post-booking-home'); // Navigate after booking
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking failed. Please try again.\nError: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your UI goes here, e.g. buttons that call _pickDate, _pickTime and _bookAppointment
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text(selectedDate == null
                  ? 'Select Date'
                  : DateFormat.yMMMd().format(selectedDate!)),
            ),
            ElevatedButton(
              onPressed: () => _pickTime(context),
              child: Text(selectedTime == null
                  ? 'Select Time'
                  : selectedTime!.format(context)),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Reason / Notes'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookAppointment,
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
