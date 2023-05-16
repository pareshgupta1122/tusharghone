import 'package:flutter/material.dart';
import 'package:tusharghone/http_helper.dart';

class Quiz with ChangeNotifier {
  final String? id;
  final String title;
  final int timer;
  final List questions;
  final List userAnswers;
  List<List<bool>> isSelected = [];

  Quiz(
      {this.id,
      required this.userAnswers, 
      required this.questions,
      required this.timer,
      required this.title,
      required this.isSelected});

  static Quiz jsonToQuiz(Map quiz) {
    return Quiz(
        id: quiz["_id"],
        isSelected: [],
        questions: quiz["questions"],
        timer: quiz["timer"],
        title: quiz["title"], userAnswers: []);
  }
}

class Questions with ChangeNotifier {
  List<Quiz> _quizQuestions = [
    // Quiz(
    //   id: "1",
    //   title: "Quiz 1",
    //   questions: [
    //     {
    //       "id": "a",
    //       "question": "What is the capital of France?",
    //       "answers": ["Paris", "London", "Madrid", "Rome"],
    //       "answer": "Paris",
    //       "score": 10,
    //     },
    //     {
    //       "id": "b",
    //       "question": "What is the currency of Japan?",
    //       "answers": ["Yuan", "Yen", "Dollar", "Euro"],
    //       "answer": "Yen",
    //       "score": 10,
    //     },
    //     {
    //       "id": "c",
    //       "question": "What is the largest planet in our solar system?",
    //       "answers": ["Venus", "Saturn", "Jupiter", "Mars"],
    //       "answer": "Jupiter",
    //       "score": 10,
    //     },
    //   ],
    //   timer: 4,
    //   isSelected: [],
    // ),
    // Quiz(
    //   id: "2",
    //   title: "Quiz 2",
    //   questions: [
    //     {
    //       "question": "What is the capital of Italy?",
    //       "answers": ["Paris", "London", "Madrid", "Rome"],
    //       "answer": "Rome",
    //       "score": 10,
    //     },
    //     {
    //       "question": "What is the currency of Canada?",
    //       "answers": ["Dollar", "Yen", "Euro", "Pound"],
    //       "answer": "Dollar",
    //       "score": 10,
    //     },
    //     {
    //       "question": "What is the smallest planet in our solar system?",
    //       "answers": ["Venus", "Saturn", "Jupiter", "Mercury"],
    //       "answer": "Mercury",
    //       "score": 10,
    //     },
    //   ],
    //   timer: 5,
    //   isSelected: [],
    // ),
  ];

  Future<bool> fetchQuizes() async {
    try {
      final url = 'http://192.168.137.1:5010/api/v1/quiz';

      final response = await RemoteServices.httpRequest(
        method: 'GET',
        url: url,
      );

      if (response['success']) {
        List<Quiz> fetchedQuizes = [];
        for (var quiz in response['data']) {
          fetchedQuizes.add(Quiz.jsonToQuiz(quiz));
        }

        _quizQuestions = fetchedQuizes;

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

  int _currentIndex = 0;
  int _score = 0;

  List<Quiz> get quizQuestions => _quizQuestions;
  int get currentIndex => _currentIndex;
  int get score => _score;

  Quiz selectedQuiz(String id) {
    return _quizQuestions.firstWhere((element) => element.id == id);
  }

  int findQuestionIndex(int quizIndex, Map<String, dynamic> question) {
    return quizQuestions[quizIndex]
        .questions
        .indexWhere((q) => q['question'] == question['question']);
  }

  void totalScore() {
    for (int i = 0; i <= quizQuestions.length; i++) {
      _score += _score;
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }

  bool isFinished() {
    return _currentIndex == _quizQuestions.length;
  }
}
