class TrainingTest {
  String id; // Unique identifier for the test
  String classId; // Reference to the associated TrainingClass
  String name; // Test name (e.g., "Final Exam")
  String type; // Type of test (e.g., "multiple-choice", "true/false", "mixed")
  List<TestQuestion> questions; // List of questions
  int passingScore; // Minimum percentage to pass
  int? timeLimit; // Time limit in minutes (optional)
  String createdBy; // User ID of the creator (instructor/admin)
  DateTime createdDate; // When the test was created

  TrainingTest({
    required this.id,
    required this.classId,
    required this.name,
    required this.type,
    required this.questions,
    required this.passingScore,
    this.timeLimit,
    required this.createdBy,
    required this.createdDate,
  });

  // Convert TrainingTest to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'name': name,
      'type': type,
      'questions': questions.map((q) => q.toJson()).toList(),
      'passingScore': passingScore,
      'timeLimit': timeLimit,
      'createdBy': createdBy,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  // Create TrainingTest from JSON retrieved from Firestore
  factory TrainingTest.fromJson(Map<String, dynamic> json) {
    return TrainingTest(
      id: json['id'],
      classId: json['classId'],
      name: json['name'],
      type: json['type'],
      questions: (json['questions'] as List<dynamic>)
          .map((q) => TestQuestion.fromJson(Map<String, dynamic>.from(q)))
          .toList(),
      passingScore: json['passingScore'],
      timeLimit: json['timeLimit'],
      createdBy: json['createdBy'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}
class TestQuestion {
  String id; // Unique identifier for the question
  String text; // Question text
  String type; // Question type (e.g., "multiple-choice", "true/false", "short-answer")
  List<String>? options; // List of answer options (for multiple-choice)
  dynamic answer; // Correct answer (String, Boolean, or List depending on type)

  TestQuestion({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.answer,
  });

  // Convert TestQuestion to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
      'options': options,
      'answer': answer,
    };
  }

  // Create TestQuestion from JSON
  factory TestQuestion.fromJson(Map<String, dynamic> json) {
    return TestQuestion(
      id: json['id'],
      text: json['text'],
      type: json['type'],
      options: (json['options'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      answer: json['answer'],
    );
  }
}

/*
TrainingTest newTest = TrainingTest(
  id: 'test_001',
  classId: 'class_001',
  name: 'Module 1 Quiz',
  type: 'mixed',
  questions: [
    TestQuestion(
      id: 'q1',
      text: 'What is Flutter?',
      type: 'multiple-choice',
      options: ['A library', 'A framework', 'A database', 'An IDE'],
      answer: 'A framework',
    ),
    TestQuestion(
      id: 'q2',
      text: 'State management is important. (True/False)',
      type: 'true/false',
      answer: true,
    ),
    TestQuestion(
      id: 'q3',
      text: 'Explain the importance of state management.',
      type: 'short-answer',
      answer: null, // Evaluated manually
    ),
  ],
  passingScore: 70, // Pass if 70% or higher
  timeLimit: 30, // 30-minute limit
  createdBy: 'instructor_001',
  createdDate: DateTime.now(),
);
Map<String, dynamic> testJson = newTest.toJson();
await FirestoreAPI.tests.add(testJson);
final snapshot = await FirestoreAPI.tests.doc('test_001').get();
if (snapshot.exists) {
  TrainingTest retrievedTest = TrainingTest.fromJson(snapshot.data()!);
  print('Test Name: ${retrievedTest.name}');
  print('First Question: ${retrievedTest.questions.first.text}');
}

{
  "id": "test_001",
  "classId": "class_001",
  "name": "Module 1 Quiz",
  "type": "mixed",
  "questions": [
    {
      "id": "q1",
      "text": "What is Flutter?",
      "type": "multiple-choice",
      "options": ["A library", "A framework", "A database", "An IDE"],
      "answer": "A framework"
    },
    {
      "id": "q2",
      "text": "State management is important. (True/False)",
      "type": "true/false",
      "answer": true
    },
    {
      "id": "q3",
      "text": "Explain the importance of state management.",
      "type": "short-answer",
      "answer": null
    }
  ],
  "passingScore": 70,
  "timeLimit": 30,
  "createdBy": "instructor_001",
  "createdDate": "2024-11-25T10:00:00.000Z"
}

 */