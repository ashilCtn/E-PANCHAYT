import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme.dart';

class MyNewButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyNewButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final primaryGradient = LinearGradient(
      colors: [
        colorScheme.primary,
        colorScheme.secondary,
        colorScheme.tertiary,
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              // color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDarkMode
                  ? AppTheme.darkThemeMode.textTheme.bodyLarge?.color ??
                      Colors.black // Fallback to default color if null
                  : AppTheme.lightThemeMode.textTheme.bodyLarge?.color ??
                      Colors.black, // Fallback to default color if null
            ),
          ),
        ),
      ),
    );
  }
}
