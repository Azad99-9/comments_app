import 'package:comments_app/services/firebase_auth_service.dart';
import 'package:comments_app/views/after_auth_views.dart/home_view.dart';
import 'package:comments_app/views/pre_auth_views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        // Show loading indicator while waiting for connection
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // If user is authenticated, show HomeView, otherwise show LoginView
          if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
        }
      },
    );
  }
}
