import 'package:flutter/material.dart';
import 'package:tusharghone/http_helper.dart';

class Course {
  final String id;
  final String imageUrl;

  final String title;
  final String subtitle;
  final String instructor;
  final String courseType;
  final String instructorImage;
  final num rating;
  final int enrolls;
  final String courseLevel;
  final int modules;
  final int hours;
  final String aboutcourse;
  final List highlights;
  final List chapters;
  final List requirements;
  final List tags;
  final String cardImage;
  final List reviews;
  bool isMarked;
  bool isEnrolled;

  bool isChecked;
  int? prize;
  final int waletMoney;

  Course({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.instructor,
    required this.courseType,
    required this.instructorImage,
    required this.rating,
    required this.enrolls,
    required this.courseLevel,
    required this.modules,
    required this.hours,
    required this.aboutcourse,
    required this.highlights,
    required this.chapters,
    required this.requirements,
    required this.tags,
    required this.cardImage,
    required this.reviews,
    this.isMarked = false,
    this.isEnrolled = false,
    this.isChecked = false,
    this.prize,
    required this.waletMoney,
  });

  static Course jsonToCourse(Map course) {
    return Course(
      aboutcourse: course['aboutcourse'] ?? '',
      title: course['title'] ?? '',
      subtitle: course['subtitle'] ?? '',
      instructor: course['instructor'] ?? '',
      courseType: course['courseType'] ?? '',
      instructorImage: course['instructorImage'] ?? '',
      rating: course['rating'] ?? 0,
      enrolls: course['enrolls'] ?? 0,
      courseLevel: course['courseLevel'] ?? '',
      modules: course['modules'] ?? 0,
      hours: course['hours'] ?? 0,
      cardImage: course['cardImage'] ?? '',
      imageUrl: course['imageUrl'] ?? '',
      isMarked: course['isMarked'] ?? false,
      isEnrolled: course['isEnrolled'] ?? false,
      isChecked: course['isChecked'] ?? false,
      prize: course['prize'] ?? 0,
      waletMoney: course['walletMoney'] ?? 0,
      tags: course['tags'] ?? [],
      highlights: course['highlights'] ?? [],
      chapters: course['chapters'] ?? [],
      requirements: course['requirements'] ?? [],
      reviews: course['reviews'] ?? [],
      id: course['_id'] ?? '',
    );
  }
}

class Courses with ChangeNotifier {
  List<Course> _courseItems = [
    // Course(
    //   waletMoney: 245,
    //   id: '1',
    //   imageUrl: 'assets/images/introimage.png',
    //   title: 'Money making course',
    //   subTitle: 'Learn & grow your wealth for your future days',
    //   instructor: 'By Tushar R. Gone',
    //   courseType: 'Free',
    //   instructorImage: 'assets/images/Ellipse.png',
    //   rating: 4.8,
    //   enrolls: 1200,
    //   courseLevel: 'Beginner',
    //   modules: 20,
    //   hours: 4,
    //   highlights: [
    //     '20 Modules',
    //     '4 levels of Interactive Content',
    //     'Level of Content-Begineer',
    //     'Quizes and Resources Included',
    //     ' Community Support Available '
    //   ],
    //   chapters: [
    //     {
    //       'title': '01 - Welcome Session',
    //       'lesson': [
    //         'How to access the MMTC course',
    //         'How to get connected to community',
    //         'How to complete the course'
    //       ],
    //     },
    //     {
    //       'title': '02 - Concepts of Trading',
    //       'lesson': [],
    //     },
    //     {
    //       'title': '03 - Tools for Trading',
    //       'lesson': [],
    //     }
    //   ],
    //   requirements: [
    //     {
    //       'imageText': 'assets/svgs/Rectangle.svg',
    //       'item': 'SmartPhone',
    //     },
    //     {
    //       'imageText': 'assets/svgs/people.svg',
    //       'item': 'Demat Account for Trading',
    //     }
    //   ],
    //   tags: [
    //     'Stock Market ',
    //     'Nifty50',
    //     'Trading',
    //     'NSE',
    //     'BSE',
    //   ],
    //   reviews: [
    //     {
    //       'name': 'Joyesh Chaudhary',
    //       'stars': 3,
    //       'time': '4 days Ago ',
    //       'description':
    //           'This is a great course that beginner can follow along easily. Instructor is also giving tips and tricks for us to remember things easily. Definitely recommend to go for it.'
    //     },
    //     {
    //       'name': 'Harish Kumar',
    //       'stars': 4,
    //       'time': '1 week Ago',
    //       'description':
    //           'I loved this course. Its exactly what I wanted to learn twenty years ago. Its really helpful to a beginner starting to trading.'
    //     },
    //   ],
    //   cardImage: 'assets/images/image.png',
    //   aboutcourse:
    //       'This Course is a comprehensive course in  stock market trading that will take you from beginner to advance level.You will be able to trade like a professional trader and start earning regular income after a few months of practice with our support. More...',
    // ),
    // Course(
    //   waletMoney: 245,
    //   id: '2',
    //   imageUrl: 'assets/images/introimage.png',
    //   title: 'Money making course',
    //   subTitle: 'Learn & grow your wealth for your future days',
    //   instructor: 'By Tushar R. Gone',
    //   courseType: 'Paid',
    //   instructorImage: 'assets/images/Ellipse.png',
    //   rating: 4.8,
    //   enrolls: 1200,
    //   courseLevel: 'Beginner',
    //   modules: 20,
    //   hours: 4,
    //   highlights: [
    //     '20 Modules',
    //     '4 levels of Interactive Content',
    //     'Level of Content-Begineer',
    //     'Quizes and Resources Included',
    //     ' Community Support Available '
    //   ],
    //   chapters: [
    //     {
    //       'title': '01 - Welcome Session',
    //       'lesson': [
    //         'How to access the MMTC course',
    //         'How to get connected to community',
    //         'How to complete the course'
    //       ],
    //     },
    //     {
    //       'title': '02 - Concepts of Trading',
    //       'lesson': [],
    //     },
    //     {
    //       'title': '03 - Tools for Trading',
    //       'lesson': [],
    //     }
    //   ],
    //   aboutcourse:
    //       'This Course is a comprehensive course in  stock market trading that will take you from beginner to advance level.You will be able to trade like a professional trader and start earning regular income after a few months of practice with our support. More...',
    //   requirements: [
    //     {
    //       'imageText': 'assets/svgs/Rectangle.svg',
    //       'item': 'SmartPhone',
    //     },
    //     {
    //       'imageText': 'assets/svgs/people.svg',
    //       'item': 'Demat Account for Trading',
    //     }
    //   ],
    //   prize: 999,
    //   cardImage: 'assets/images/image.png',
    //   tags: [
    //     'Stock Market ',
    //     'Nifty50',
    //     'Trading',
    //     'NSE',
    //     'BSE',
    //   ],
    //   reviews: [
    //     {
    //       'name': 'Joyesh Chaudhary',
    //       'stars': 2,
    //       'time': '4 days Ago ',
    //       'description':
    //           'This is a great course that beginner can follow along easily. Instructor is also giving tips and tricks for us to remember things easily. Definitely recommend to go for it.'
    //     },
    //     {
    //       'name': 'Harish Kumar',
    //       'stars': 3,
    //       'time': '1 week Ago',
    //       'description':
    //           'I loved this course. Its exactly what I wanted to learn twenty years ago. Its really helpful to a beginner starting to trading.'
    //     },
    //   ],
    // ),
    // Course(
    //   waletMoney: 245,
    //   id: '3',
    //   imageUrl: 'assets/images/introimage.png',
    //   title: 'Money making course',
    //   subTitle: 'Learn & grow your wealth for your future days',
    //   instructor: 'By Tushar R. Gone',
    //   courseType: 'Free',
    //   instructorImage: 'assets/images/Ellipse.png',
    //   rating: 4.8,
    //   enrolls: 1200,
    //   courseLevel: 'Beginner',
    //   modules: 20,
    //   hours: 4,
    //   highlights: [
    //     '20 Modules',
    //     '4 levels of Interactive Content',
    //     'Level of Content-Begineer',
    //     'Quizes and Resources Included',
    //     ' Community Support Available '
    //   ],
    //   chapters: [
    //     {
    //       'title': '01 - Welcome Session',
    //       'lesson': [
    //         'How to access the MMTC course',
    //         'How to get connected to community',
    //         'How to complete the course'
    //       ],
    //     },
    //     {
    //       'title': '02 - Concepts of Trading',
    //       'lesson': [],
    //     },
    //     {
    //       'title': '03 - Tools for Trading',
    //       'lesson': [],
    //     }
    //   ],
    //   requirements: [
    //     {
    //       'imageText': 'assets/svgs/Rectangle.svg',
    //       'item': 'SmartPhone',
    //     },
    //     {
    //       'imageText': 'assets/svgs/people.svg',
    //       'item': 'Demat Account for Trading',
    //     }
    //   ],
    //   tags: [
    //     'Stock Market ',
    //     'Nifty50',
    //     'Trading',
    //     'NSE',
    //     'BSE',
    //   ],
    //   reviews: [
    //     {
    //       'name': 'Joyesh Chaudhary',
    //       'stars': 2,
    //       'time': '4 days Ago ',
    //       'description':
    //           'This is a great course that beginner can follow along easily. Instructor is also giving tips and tricks for us to remember things easily. Definitely recommend to go for it.'
    //     },
    //     {
    //       'name': 'Harish Kumar',
    //       'stars': 3,
    //       'time': '1 week Ago',
    //       'description':
    //           'I loved this course. Its exactly what I wanted to learn twenty years ago. Its really helpful to a beginner starting to trading.'
    //     },
    //   ],
    //   cardImage: 'assets/images/image.png',
    //   aboutcourse:
    //       'This Course is a comprehensive course in  stock market trading that will take you from beginner to advance level.You will be able to trade like a professional trader and start earning regular income after a few months of practice with our support. More...',
    // ),
  ];

  Future<bool> fetchCourses() async {
     try {
    final url = 'http://192.168.137.1:5010/api/v1/TgCourses';

    final response = await RemoteServices.httpRequest(
      method: 'GET',
      url: url,
    );

    if (response['success']) {
      List<Course> fetchedCourses = [];
      for (var course in response['data']) {
        fetchedCourses.add(Course.jsonToCourse(course));
      }

      _courseItems = fetchedCourses;

      notifyListeners();
      return true;
    } else {
      return false;
    }
    }
    catch (e) {
      print(e);
      return false;
    }
  }

  List<Course> getCourseByType(String type) {
    return _courseItems.where((course) => course.courseType == type).toList();
  }

  List<Course> get couseItems {
    return [..._courseItems];
  }

  void markWishlist(String courseId) {
    int index = _courseItems.indexWhere((course) => course.id == courseId);
    if (index != -1) {
      _courseItems[index].isMarked = !_courseItems[index].isMarked;
    }

    notifyListeners();
  }

  List<Course> fetchWishlistItems(List id) {
    return _courseItems.where((course) => id.contains(course.id)).toList();
  }

  List<Course> fetchEnrolledItems(List id) {
    return _courseItems.where((course) => id.contains(course.id)).toList();
  }

  void removeWishlist(String courseId) {
    int index = _courseItems.indexWhere((course) => course.id == courseId);
    if (index != -1) {
      _courseItems[index].isChecked = !_courseItems[index].isChecked;

      notifyListeners();
    }
  }

  Course selectedcourse(String id) {
    return _courseItems.firstWhere((element) => element.id == id);
  }

  List<Course> get markedCourse {
    return _courseItems.where((course) => course.isMarked).toList();
  }

  List<Course> _markedWishList = [];

  List<Course> get markedWishlist => _markedWishList;

  void removeWishItem() {
    markedCourse.forEach((element) {
      //if we want to update or to iterate foreach is used
      if (element.isChecked) {
        element.isMarked = !element.isMarked;
        element.isChecked = !element.isChecked;
      }
    });

    notifyListeners();
  }

  bool isEmptyWishlist() {
    if (markedCourse.isEmpty) {
      return true;
    }
    return false;
  }

  void isEnrolled(String courseId) {
    int index = _courseItems.indexWhere((course) => course.id == courseId);
    if (index != -1) {
      _courseItems[index].isEnrolled = !_courseItems[index].isEnrolled;
      notifyListeners();
    }
  }

  List<Course> get enrolledCourses {
    return _courseItems.where((element) => element.isEnrolled).toList();
  }
}
