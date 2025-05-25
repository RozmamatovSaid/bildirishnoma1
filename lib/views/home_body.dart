import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 280,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              spacing: 20,
              children: [
                Text(
                  'TOKEN!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SelectableText(token),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Tokenni nusxalab firebase orqali jo'nating!",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
