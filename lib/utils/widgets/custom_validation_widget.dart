import 'package:flutter/material.dart';

class CustomValidationWidget extends StatelessWidget {
  final bool isValid;
  final String errorMessage;
  final Widget child;
  final bool borderRequired;

  const CustomValidationWidget({
    Key? key,
    required this.isValid,
    this.errorMessage = "Invalid input",
    required this.child,
    this.borderRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
// Main widget with optional border
        Container(
          decoration: borderRequired
              ? BoxDecoration(
                  border: Border.all(
                    color: isValid ? theme.primaryColor : theme.colorScheme.error, // Border color based on validation state
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: child,
        ),

// Display error message if not valid
        if (!isValid)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage,
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
