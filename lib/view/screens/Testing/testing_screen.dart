import 'dart:ui';

import 'package:flutter/material.dart';



class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blurred Background Container'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9), // Semi-transparent background color
              borderRadius: BorderRadius.circular(10),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 200, sigmaY: 1), // Blur effect
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Make the inner container transparent
                ),
                child: const Center(
                  child: Text(
                    'This is a blurred background container.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
