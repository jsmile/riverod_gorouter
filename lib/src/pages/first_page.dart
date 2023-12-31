import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/router/router_names.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('First Page'),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                GoRouter.of(context).goNamed(RouterNames.firstDetails);
              },
              child: const Text('View First Details'),
            ),
          ],
        ),
      ),
    );
  }
}
