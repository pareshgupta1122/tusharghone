import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tusharghone/http_helper.dart';

class User {
  final String? id;
  final String name;
  final String email;
  DateTime dob;
  final String gender;
  final String phone;

  final List courseIds;
  final List enrolledCourseIds;

  User( {
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
      enrolledCourseIds: user['enrolledCourses']??[]

    );
  }
}

class Users with ChangeNotifier {
  final LocalStorage storage = LocalStorage('tusharghone');
  late User _userdetails;

  User get userdetails {
    return _userdetails;
  }

  void addUser(User user) {
    _userdetails = user;
    notifyListeners();
  }

  Future<bool> login(String phone) async {
    try {
      final url = 'http://192.168.137.1:5010/api/v1/users/login';
//${webDomain['domain']}${api['login']}
      final response = await RemoteServices.httpRequest(
        method: 'POST',
        url: url,
        body: {'phone': phone},
      );

      if (response['success']) {
        User user = User.jsonToUser(response['data']);
        _userdetails = user;
        saveUserInStorage();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(String phone, String name, String email, String dob,
      String gender) async {
    try {
      final url = 'http://192.168.137.1:5010/api/v1/users/register';

      final response = await RemoteServices.httpRequest(
        method: 'POST',
        url: url,
        body: {
          'phone': phone,
          'name': name,
          'email': email,
          'dob': dob,
          'gender': gender
        },
      );

      if (response['success']) {
        User user = User.jsonToUser(response['data']);
        _userdetails = user;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> wishlist(String courseId, bool value) async {
    try {
      final url = 'http://192.168.137.1:5010/api/v1/users';

      final response = await RemoteServices.httpRequest(
          method: 'POST',
          url: url,
          body: {
            'userId': _userdetails.id,
            'courseId': courseId,
            'value': value
          });

      if (response['success'] && response['data'] != null) {
        if (value) {
          _userdetails.courseIds.add(courseId);
        } else {
          _userdetails.courseIds.remove(courseId);
        }
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> enrolledCourses(String courseId, bool value) async {
    try {
      final url = 'http://192.168.137.1:5010/api/v1/users';

      final response = await RemoteServices.httpRequest(
          method: 'PUT',
          url: url,
          body: {
            'userId': _userdetails.id,
            'courseId': courseId,
            'value': value
          });

      if (response['success'] && response['data'] != null) {
        if (value) {
          _userdetails.enrolledCourseIds.add(courseId);
        } else {
          _userdetails.enrolledCourseIds.remove(courseId);
        }
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  saveUserInStorage() async {
    await storage.ready;
    storage.setItem(
        'accessToken',
        json.encode({
          "phone": _userdetails.phone,
        }));
  }

  void removeCourseId(List courseId) {
    for (int i = 0; i < courseId.length; i++) {
      if (_userdetails.courseIds.contains(courseId[i])) {
        _userdetails.courseIds.remove(courseId[i]);
      }
    }

    notifyListeners();
  }
}
