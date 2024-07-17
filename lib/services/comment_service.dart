import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comments_app/models/comment.dart';

class CommentService {
  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
