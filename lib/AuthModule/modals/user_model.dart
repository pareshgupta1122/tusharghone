class User {
  final String? id;
  final String name;
  final String email;
  DateTime dob;
  final String gender;
  final String phone;

  final List courseIds;
  final List enrolledCourseIds;

  User({
    required this.enrolledCourseIds,
    required this.courseIds,
    this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
  });

  static User jsonToUser(Map user) {
    return User(
        phone: user['phone'] ?? '',
        name: user['name'] ?? '',
        email: user['email'] ?? '',
        dob: DateTime.parse(user['dob']).toLocal(),
        gender: user['gender'] ?? '',
        courseIds: user['courseIds'] ?? [],
        id: user['_id'] ?? '',
        enrolledCourseIds: user['enrolledCourses'] ?? []);
  }
}
