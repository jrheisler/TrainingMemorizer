class TrainingClass {
  String id; // Unique identifier for the class
  String name; // Class name (e.g., "Introduction to Flutter")
  String description; // Detailed description of the class
  List<String> objectives; // List of learning objectives
  List<Map<String, dynamic>> materials; // Links to resources
  int duration; // Duration of the class in minutes
  String createdBy; // User ID of the creator (instructor/admin)
  DateTime createdDate; // When the class was created
  List<String> tags; // Keywords for categorizing/searching
  String? imageUrl; // Optional image URL for class thumbnail
  List<ClassElement> content; // List of elements defining the course content

  TrainingClass({
    required this.id,
    required this.name,
    required this.description,
    required this.objectives,
    required this.materials,
    required this.duration,
    required this.createdBy,
    required this.createdDate,
    required this.tags,
    this.imageUrl,
    required this.content,
  });

  // Convert TrainingClass to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'objectives': objectives,
      'materials': materials,
      'duration': duration,
      'createdBy': createdBy,
      'createdDate': createdDate.toIso8601String(),
      'tags': tags,
      'imageUrl': imageUrl,
      'content': content.map((e) => e.toJson()).toList(),
    };
  }

  // Create TrainingClass from JSON retrieved from Firestore
  factory TrainingClass.fromJson(Map<String, dynamic> json) {
    return TrainingClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      objectives: List<String>.from(json['objectives'] ?? []),
      materials: List<Map<String, dynamic>>.from(json['materials'] ?? []),
      duration: json['duration'],
      createdBy: json['createdBy'],
      createdDate: DateTime.parse(json['createdDate']),
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'],
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ClassElement.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}
class ClassElement {
  String name; // Name of the element or UI signal
  String line; // Main content text
  String url; // Primary resource URL
  String? url2; // Optional secondary resource URL
  String type; // Type of element (e.g., "text", "video", "image", "quiz", etc.)
  String visibility; // Visibility scope (e.g., "student", "instructor", "both")

  ClassElement({
    required this.name,
    required this.line,
    required this.url,
    this.url2,
    required this.type,
    required this.visibility,
  });

  // Convert ClassElement to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'line': line,
      'url': url,
      'url2': url2,
      'type': type,
      'visibility': visibility,
    };
  }

  // Create ClassElement from JSON
  factory ClassElement.fromJson(Map<String, dynamic> json) {
    return ClassElement(
      name: json['name'],
      line: json['line'],
      url: json['url'],
      url2: json['url2'],
      type: json['type'],
      visibility: json['visibility'],
    );
  }
}

/*
TrainingClass newClass = TrainingClass(
  id: 'class_001',
  name: 'Introduction to Flutter',
  description: 'Learn the basics of Flutter development.',
  objectives: ['Understand widgets', 'Build a simple app', 'State management basics'],
  materials: [
    {
      'type': 'PDF',
      'url': 'https://example.com/flutter-basics.pdf',
      'title': 'Flutter Basics Guide',
    },
    {
      'type': 'Video',
      'url': 'https://youtube.com/example-video',
      'title': 'Flutter Widgets Overview',
    },
  ],
  duration: 120,
  createdBy: 'user_001',
  createdDate: DateTime.now(),
  tags: ['Flutter', 'Beginner', 'Development'],
  content: [
    ClassElement(
      name: 'Introduction',
      line: 'Welcome to the class! Let’s start with an overview.',
      url: 'https://example.com/intro-video.mp4',
      url2: 'http://localhost/intro-video.mp4',
    ),
    ClassElement(
      name: 'Lesson 1',
      line: 'Learn about Flutter widgets and their importance.',
      url: 'https://example.com/widgets-guide.pdf',
    ),
    ClassElement(
      name: 'Quiz',
      line: 'Test your understanding of widgets.',
      url: 'https://example.com/widgets-quiz',
    ),
  ],
  imageUrl: 'https://example.com/class-thumbnail.jpg',
);


Map<String, dynamic> classJson = newClass.toJson();
await FirestoreAPI.classes.add(classJson);


final snapshot = await FirestoreAPI.classes.doc('class_001').get();
if (snapshot.exists) {
  TrainingClass retrievedClass = TrainingClass.fromJson(snapshot.data()!);
  print('Class Name: ${retrievedClass.name}');
  print('First Content Line: ${retrievedClass.content.first.line}');
}

 */