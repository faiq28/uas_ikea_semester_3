import 'package:flutter/material.dart';
import 'utility/defColor.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/image 2 (1).png'),
            SizedBox(height: 24),
            Text(
              'Creating a better everyday life \nthe many people.',
              style: TextStyle(
                color: secondText,
                fontSize: 12.8,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
