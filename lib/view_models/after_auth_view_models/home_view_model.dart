import 'package:comments_app/services/comment_service.dart';
import 'package:comments_app/services/firebase_auth_service.dart';
import 'package:comments_app/models/comment.dart'; // Assuming you have a Comment model
import 'package:comments_app/services/firebase_remote_config_service.dart';
import 'package:comments_app/views/pre_auth_views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  late final FirebaseAuthService _authService;
  late final BuildContext _context;

  HomeViewModel({
    required FirebaseAuthService authService,
    required FirebaseRemoteConfigService remoteConfigService,
    required BuildContext context,
  }) {
    _context = context;
    _authService = authService;
    remoteConfigService.initialise();
    fetchComments();
  }

  List<Comment> comments = [];

  final CommentService _commentService = CommentService();

  Future<void> fetchComments() async {
    try {
      setBusy(true);
      comments = await _commentService
          .fetchComments(); // Implement this method in your Firestore service
    } catch (e) {
      rethrow;
    } finally {
      setBusy(false);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      if (_context.mounted) {
        Navigator.pushReplacement(
            _context, MaterialPageRoute(builder: (context) => LoginView()));
      }
    } catch (e) {
      rethrow;
    }
  }
}
