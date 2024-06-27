import 'package:flutter/material.dart';

class PreDefText extends StatefulWidget {
  final String label;
  final String dataValue;

  PreDefText({
    super.key,
    required this.label,
    required this.dataValue,
  });

  @override
  State<PreDefText> createState() => _PreDefTextState();
}

class _PreDefTextState extends State<PreDefText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.dataValue,
      decoration: InputDecoration(labelText: widget.label),
      maxLines: null,
      enabled: false,
    );
  }
}
