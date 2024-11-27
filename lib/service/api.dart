import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAPI {
  // Singleton instance
  FirestoreAPI._();
  static final FirestoreAPI instance = FirestoreAPI._();

  // Collection paths
  static const String usersCollection = 'training_users';
  static const String classesCollection = 'training_classes';
  static const String eventsCollection = 'training_events';
  static const String testsCollection = 'training_tests';
  static const String resultsCollection = 'training_results';
  static const String indexesCollection = 'indexes';

  // Document paths
  static String classIndexDocument = '$indexesCollection/training_classes_index';

  // Collection references
  static CollectionReference get users => FirebaseFirestore.instance.collection(usersCollection);
  static CollectionReference get classes => FirebaseFirestore.instance.collection(classesCollection);
  static CollectionReference get events => FirebaseFirestore.instance.collection(eventsCollection);
  static CollectionReference get tests => FirebaseFirestore.instance.collection(testsCollection);
  static CollectionReference get results => FirebaseFirestore.instance.collection(resultsCollection);

  // Dynamic document references
  static DocumentReference getClassIndexDocument() {
    return FirebaseFirestore.instance.collection(indexesCollection).doc('training_classes_index');
  }

  // Example for subcollections
  static CollectionReference getEventParticipants(String eventId) {
    return FirebaseFirestore.instance
        .collection(eventsCollection)
        .doc(eventId)
        .collection('participants');
  }

  static CollectionReference getTestQuestions(String testId) {
    return FirebaseFirestore.instance
        .collection(testsCollection)
        .doc(testId)
        .collection('questions');
  }
}


/*
Future<List<QueryDocumentSnapshot>> getTestQuestions(String testId) async {
  final snapshot = await FirestoreAPI.getTestQuestions(testId).get();
  return snapshot.docs;
}
Future<void> updateClassIndex(List<Map<String, dynamic>> updatedClasses) async {
  await FirestoreAPI.getClassIndexDocument().update({
    'classes': updatedClasses,
  });
}
Future<void> addTrainingClass(Map<String, dynamic> classData) async {
  await FirestoreAPI.classes.add(classData);
}
Future<List<QueryDocumentSnapshot>> getAllClasses() async {
  final snapshot = await FirestoreAPI.classes.get();
  return snapshot.docs;
}

 */