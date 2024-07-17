import 'package:comments_app/services/firebase_auth_service.dart';
import 'package:comments_app/services/firebase_cloud_firestore_service.dart';
import 'package:comments_app/view_models/auth_view_model.dart';
import 'package:comments_app/views/pre_auth_views/login_view.dart';
import 'package:comments_app/widgets/custom_floating_action_button.dart';
import 'package:comments_app/widgets/custom_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(
        authService: Provider.of<FirebaseAuthService>(context),
        firebaseFirestoreService: Provider.of<FirebaseFirestoreService>(context),
        context: context,
      ),
      builder: (context, viewModel, child) {
        viewModel.isLogin = false;
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildForm(viewModel),
          floatingActionButton: _buildFloatingActionButton(viewModel),
          bottomNavigationBar: _buildBottomNavigationBar(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  // Builds the AppBar widget
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Comments',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  // Builds the form with name, email, and password fields
  Widget _buildForm(AuthViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTextFormField(
              key: const ValueKey('name'),
              labelText: 'Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
              onSaved: (value) {
                viewModel.name = value!;
              },
            ),
            _buildTextFormField(
              key: const ValueKey('email'),
              labelText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onSaved: (value) {
                viewModel.email = value!;
              },
            ),
            _buildTextFormField(
              key: const ValueKey('password'),
              labelText: 'Password',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 7) {
                  return 'Password must be at least 7 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                viewModel.password = value!;
              },
            ),
          ],
        ),
      ),
    );
  }

  // Builds a custom text form field
  Widget _buildTextFormField({
    required Key key,
    required String labelText,
    bool obscureText = false,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return CustomTextFormField(
      key: key,
      labelText: labelText,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }

  // Builds the floating action button for form submission
  Widget _buildFloatingActionButton(AuthViewModel viewModel) {
    return CustomFloatingButton(
      model: viewModel,
      onPressed: viewModel.submitForm,
      buttonText: 'Signup',
    );
  }

  // Builds the bottom navigation bar with a login link
  Widget _buildBottomNavigationBar(BuildContext context) {
    return CustomTextLink(
      buttonText: 'Login',
      questionText: 'Already have an account? ',
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      },
    );
  }
}
