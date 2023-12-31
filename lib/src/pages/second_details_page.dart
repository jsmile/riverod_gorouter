import 'package:flutter/material.dart';

class SecondDetailsPage extends StatelessWidget {
  const SecondDetailsPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Detail Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Text(
          'your id: $id',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
