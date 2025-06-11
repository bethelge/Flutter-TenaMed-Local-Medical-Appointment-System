class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String reason;
  final DateTime date;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.reason,
    required this.date,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      reason: json['reason'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'reason': reason,
      'date': date.toIso8601String(),
    };
  }
}
