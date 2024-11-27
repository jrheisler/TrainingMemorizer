class TrainingEvent {
  String id; // Unique identifier for the event
  String classId; // Reference to the associated TrainingClass
  DateTime startDate; // Event start date and time
  DateTime endDate; // Event end date and time
  String instructorId; // Reference to the instructor
  List<String> participantIds; // List of user IDs attending the event
  List<String> testIds; // List of associated TrainingTest IDs
  String state; // Event state (e.g., "scheduled", "in-progress", "completed", "cancelled")
  String? location; // Physical address or virtual meeting link
  String? notes; // Optional notes about the event
  Map<String, bool>? attendance; // Tracks attendance (key: participantId, value: attended)
  Recurrence? recurrence; // Recurrence pattern for the event
  Map<String, String>? feedback; // Participant feedback (key: participantId, value: feedback)

  TrainingEvent({
    required this.id,
    required this.classId,
    required this.startDate,
    required this.endDate,
    required this.instructorId,
    required this.participantIds,
    required this.testIds,
    required this.state,
    this.location,
    this.notes,
    this.attendance,
    this.recurrence,
    this.feedback,
  });

  // Convert TrainingEvent to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'instructorId': instructorId,
      'participantIds': participantIds,
      'testIds': testIds,
      'state': state,
      'location': location,
      'notes': notes,
      'attendance': attendance,
      'recurrence': recurrence?.toJson(),
      'feedback': feedback,
    };
  }

  // Create TrainingEvent from JSON retrieved from Firestore
  factory TrainingEvent.fromJson(Map<String, dynamic> json) {
    return TrainingEvent(
      id: json['id'],
      classId: json['classId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      instructorId: json['instructorId'],
      participantIds: List<String>.from(json['participantIds'] ?? []),
      testIds: List<String>.from(json['testIds'] ?? []),
      state: json['state'],
      location: json['location'],
      notes: json['notes'],
      attendance: json['attendance'] != null
          ? Map<String, bool>.from(json['attendance'])
          : null,
      recurrence: json['recurrence'] != null
          ? Recurrence.fromJson(Map<String, dynamic>.from(json['recurrence']))
          : null,
      feedback: json['feedback'] != null
          ? Map<String, String>.from(json['feedback'])
          : null,
    );
  }
}
class Recurrence {
  String frequency; // Frequency (e.g., "daily", "weekly", "monthly")
  int interval; // Interval between recurrences (e.g., every 2 days)
  DateTime? endRecurrence; // End date for the recurrence, if any

  Recurrence({
    required this.frequency,
    required this.interval,
    this.endRecurrence,
  });

  // Convert Recurrence to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'frequency': frequency,
      'interval': interval,
      'endRecurrence': endRecurrence?.toIso8601String(),
    };
  }

  // Create Recurrence from JSON
  factory Recurrence.fromJson(Map<String, dynamic> json) {
    return Recurrence(
      frequency: json['frequency'],
      interval: json['interval'],
      endRecurrence: json['endRecurrence'] != null
          ? DateTime.parse(json['endRecurrence'])
          : null,
    );
  }
}

/*
TrainingEvent recurringEvent = TrainingEvent(
  id: 'event_002',
  classId: 'class_001',
  startDate: DateTime(2024, 12, 2, 9, 0),
  endDate: DateTime(2024, 12, 2, 17, 0),
  instructorId: 'instructor_001',
  participantIds: ['student_001', 'student_002'],
  testIds: ['test_001'],
  state: 'scheduled',
  location: 'https://zoom.us/meeting/recurring-link',
  notes: 'This class repeats weekly.',
  recurrence: Recurrence(
    frequency: 'weekly',
    interval: 1,
    endRecurrence: DateTime(2025, 1, 1),
  ),
  attendance: {'student_001': false, 'student_002': false},
);
{
  "id": "event_002",
  "classId": "class_001",
  "startDate": "2024-12-02T09:00:00.000Z",
  "endDate": "2024-12-02T17:00:00.000Z",
  "instructorId": "instructor_001",
  "participantIds": ["student_001", "student_002"],
  "testIds": ["test_001"],
  "state": "scheduled",
  "location": "https://zoom.us/meeting/recurring-link",
  "notes": "This class repeats weekly.",
  "attendance": {
    "student_001": false,
    "student_002": false
  },
  "recurrence": {
    "frequency": "weekly",
    "interval": 1,
    "endRecurrence": "2025-01-01T00:00:00.000Z"
  },
  "feedback": {
    "student_001": "Great class, learned a lot!",
    "student_002": "Needed more examples."
  }
}


 */