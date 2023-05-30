import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final String title;
  final String text;
  const CustomBanner({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 30),
          ),
          Text(this.text)
        ],
      ),
    );
  }
}
