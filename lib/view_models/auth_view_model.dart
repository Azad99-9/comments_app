import 'package:comments_app/services/firebase_cloud_firestore_service.dart';
import 'package:comments_app/views/after_auth_views.dart/home_view.dart';
import 'package:comments_app/views/pre_auth_views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../services/firebase_auth_service.dart';

class AuthViewModel extends BaseViewModel {
  final FirebaseAuthService _authService;
  final FirebaseFirestoreService _firebaseFirestoreService;
  String? _errorMessage;

  AuthViewModel(
      {required FirebaseAuthService authService,
      required FirebaseFirestoreService firebaseFirestoreService,
      required BuildContext context})
      : _authService = authService,
        _firebaseFirestoreService = firebaseFirestoreService,
        _context = context;

  User? get user => _authService.user;

  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  bool isLogin = true;

  late BuildContext _context;

  Future<bool> submitForm() async {
    setBusy(true);
    final isValid = formKey.currentState!.validate();
    notifyListeners();
    late final bool authenticated;
    if (isValid) {
      formKey.currentState!.save();
      // Use _email, _password, and optionally _name variables for authentication logic
      // For demo purposes, just
      //
      //print them
      if (isLogin) {
        authenticated = await signIn(email, password);
      } else {
        authenticated = await register(email, password);
      }

      if (authenticated && _context.mounted) {
        Navigator.pushReplacement(
            _context, MaterialPageRoute(builder: (builder) => HomeView()));
      }

      return authenticated;

      // Add your authentication logic here (sign up or login)
    }
    setBusy(false);
    return false;
  } // Switch between login and signup modes

  Future<bool> signIn(String email, String password) async {
    setBusy(true);
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> signOut() async {
    setBusy(true);
    try {
      await _authService.signOut();
      if (_context.mounted) {
        Navigator.push(
            _context, MaterialPageRoute(builder: (context) => LoginView()));
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> register(String email, String password) async {
    setBusy(true);
    try {
      await _authService.registerWithEmailAndPassword(email, password);
      await _firebaseFirestoreService.createUser(
          user: user, name: name, email: email);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      setBusy(false);
    }
  }
}
