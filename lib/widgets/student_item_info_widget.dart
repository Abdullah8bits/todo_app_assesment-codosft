import 'package:flutter/material.dart';

class StudentItemInfoWidget extends StatelessWidget {
  final String title, value;
  final double space;
  const StudentItemInfoWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.space});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: space,
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
