import 'package:comments_app/constants/app_theme.dart';
import 'package:comments_app/services/firebase_cloud_firestore_service.dart';
import 'package:comments_app/views/pre_auth_views/startup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthService()),
        Provider(create: (_) => FirebaseFirestoreService())
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth MVVM',
        theme: AppTheme.lightTheme,
        home: StartupView(),
      ),
    );
  }
}
