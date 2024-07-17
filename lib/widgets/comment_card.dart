import 'package:comments_app/services/firebase_remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:comments_app/models/comment.dart';

class ProfileCard extends StatelessWidget {
  final Comment comment;
  final FirebaseRemoteConfigService remoteConfigService;

  const ProfileCard({
    required this.comment,
    required this.remoteConfigService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        height: MediaQuery.of(context).size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar with initial
              _buildAvatar(context),
              const SizedBox(width: 12.0),
              // Column for Name, Email, Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText(
                      context,
                      label: 'Name: ',
                      value: comment.name,
                    ),
                    const SizedBox(height: 1.0),
                    _buildRichText(
                      context,
                      label: 'Email: ',
                      value: remoteConfigService.displayFullEmail
                          ? comment.email
                          : maskEmail(comment.email),
                    ),
                    const SizedBox(height: 1.0),
                    Text(
                      comment.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a CircleAvatar widget with the user's initial
  Widget _buildAvatar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.13,
      width: MediaQuery.of(context).size.width * 0.13,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        radius: MediaQuery.of(context).size.width * 0.1,
        child: Text(
          comment.name.isNotEmpty ? comment.name[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }

  // Builds a RichText widget for displaying labels and values
  Widget _buildRichText(BuildContext context,
      {required String label, required String value}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  String maskEmail(String email) {
    if (email.isEmpty) return '';

    // Split the email into local part and domain part
    List<String> parts = email.split('@');
    if (parts.length != 2) return email; // Invalid email format

    String localPart = parts[0];
    String domainPart = parts[1];

    // Ensure at least three characters are displayed
    String maskedLocalPart = localPart.substring(0, 3);

    // Mask the remaining characters in the local part
    maskedLocalPart += '*' * (localPart.length - 3);

    return '$maskedLocalPart@$domainPart';
  }
}
