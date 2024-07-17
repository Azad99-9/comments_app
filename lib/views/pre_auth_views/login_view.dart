import 'package:comments_app/services/firebase_auth_service.dart';
import 'package:comments_app/services/firebase_cloud_firestore_service.dart';
import 'package:comments_app/view_models/auth_view_model.dart';
import 'package:comments_app/views/pre_auth_views/signup_view.dart';
import 'package:comments_app/widgets/custom_floating_action_button.dart';
import 'package:comments_app/widgets/custom_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(
        authService: Provider.of<FirebaseAuthService>(context),
        firebaseFirestoreService: Provider.of<FirebaseFirestoreService>(context),
        context: context,
      ),
      builder: (context, viewModel, child) {
        viewModel.isLogin = true;
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

  // Builds the form with email and password fields
  Widget _buildForm(AuthViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextFormField(
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
            CustomTextFormField(
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

  // Builds the floating action button for form submission
  Widget _buildFloatingActionButton(AuthViewModel viewModel) {
    return CustomFloatingButton(
      model: viewModel,
      onPressed: viewModel.submitForm,
      buttonText: 'Login',
    );
  }

  // Builds the bottom navigation bar with a signup link
  Widget _buildBottomNavigationBar(BuildContext context) {
    return CustomTextLink(
      buttonText: 'Signup',
      questionText: 'New here? ',
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      },
    );
  }
}
