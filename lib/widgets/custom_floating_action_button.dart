import 'package:comments_app/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final EdgeInsets padding;
  final AuthViewModel model;

  const CustomFloatingButton({
    required this.onPressed,
    required this.buttonText,
    required this.model,
    this.padding = const EdgeInsets.symmetric(horizontal: 80),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: onPressed,
          label: model.isBusy
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              : Text(buttonText),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class CustomTextLink extends StatelessWidget {
  final VoidCallback onTap;
  final EdgeInsets padding;
  final String questionText;
  final String buttonText;

  const CustomTextLink({
    required this.onTap,
    this.padding = const EdgeInsets.only(bottom: 16),
    required this.questionText,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(questionText),
          InkWell(
            onTap: onTap,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
