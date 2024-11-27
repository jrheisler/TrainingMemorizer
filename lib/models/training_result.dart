class TrainingResult {
  String id; // Unique identifier for the result
  String testId; // Reference to the associated TrainingTest
  String userId; // Reference to the TrainingUser who took the test
  int score; // User’s score in percentage
  String status; // Status of the result (e.g., "passed", "failed", "incomplete")
  DateTime completedDate; // Timestamp when the test was completed
  List<UserAnswer> answers; // User’s answers to the questions

  TrainingResult({
    required this.id,
    required this.testId,
    required this.userId,
    required this.score,
    required this.status,
    required this.completedDate,
    required this.answers,
  });

  // Convert TrainingResult to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testId': testId,
      'userId': userId,
      'score': score,
      'status': status,
      'completedDate': completedDate.toIso8601String(),
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }

  // Create TrainingResult from JSON retrieved from Firestore
  factory TrainingResult.fromJson(Map<String, dynamic> json) {
    return TrainingResult(
      id: json['id'],
      testId: json['testId'],
      userId: json['userId'],
      score: json['score'],
      status: json['status'],
      completedDate: DateTime.parse(json['completedDate']),
      answers: (json['answers'] as List<dynamic>)
          .map((a) => UserAnswer.fromJson(Map<String, dynamic>.from(a)))
          .toList(),
    );
  }
}
class UserAnswer {
  String questionId; // ID of the question being answered
  dynamic answer; // User's answer (String, Boolean, or List depending on question type)
  bool isCorrect; // Indicates whether the answer is correct

  UserAnswer({
    required this.questionId,
    required this.answer,
    required this.isCorrect,
  });

  // Convert UserAnswer to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
      'isCorrect': isCorrect,
    };
  }

  // Create UserAnswer from JSON
  factory UserAnswer.fromJson(Map<String, dynamic> json) {
    return UserAnswer(
      questionId: json['questionId'],
      answer: json['answer'],
      isCorrect: json['isCorrect'],
    );
  }
}

/*
TrainingResult result = TrainingResult(
  id: 'result_001',
  testId: 'test_001',
  userId: 'student_001',
  score: 85,
  status: 'passed',
  completedDate: DateTime.now(),
  answers: [
    UserAnswer(
      questionId: 'q1',
      answer: 'A framework',
      isCorrect: true,
    ),
    UserAnswer(
      questionId: 'q2',
      answer: true,
      isCorrect: true,
    ),
    UserAnswer(
      questionId: 'q3',
      answer: 'State management simplifies app complexity.',
      isCorrect: false, // Manually evaluated
    ),
  ],
);

Map<String, dynamic> resultJson = result.toJson();
await FirestoreAPI.results.add(resultJson);

final snapshot = await FirestoreAPI.results.doc('result_001').get();
if (snapshot.exists) {
  TrainingResult retrievedResult = TrainingResult.fromJson(snapshot.data()!);
  print('User ID: ${retrievedResult.userId}');
  print('Score: ${retrievedResult.score}');
}

{
  "id": "result_001",
  "testId": "test_001",
  "userId": "student_001",
  "score": 85,
  "status": "passed",
  "completedDate": "2024-11-25T15:00:00.000Z",
  "answers": [
    {
      "questionId": "q1",
      "answer": "A framework",
      "isCorrect": true
    },
    {
      "questionId": "q2",
      "answer": true,
      "isCorrect": true
    },
    {
      "questionId": "q3",
      "answer": "State management simplifies app complexity.",
      "isCorrect": false
    }
  ]
}


 */