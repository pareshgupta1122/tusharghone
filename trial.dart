// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<List<dynamic>> fetchData() async {
//   final response = await http.get(Uri.parse('https:http://10.10.0.240:5000/'));
//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON
//     return jsonDecode(response.body);
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load data');
//   }
// }
// https:http://10.10.0.240:5000//api/v1/users/login