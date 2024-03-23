import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('images/AdviserLogo.png'))),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}
