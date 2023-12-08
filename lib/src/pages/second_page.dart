import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverod_gorouter/src/config/router/router_names.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Second Page'),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                GoRouter.of(context).goNamed(
                  RouterNames.secondDetails,
                  pathParameters: {'id': '1'},
                );
              },
              child: const Text('View Second Details'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                context.go('/nowhere');
              },
              child: const Text('No Where'),
            )
          ],
        ),
      ),
    );
  }
}
