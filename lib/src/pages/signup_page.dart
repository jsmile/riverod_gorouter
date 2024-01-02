import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/router/auth_state_provider.dart';
import '../config/router/router_names.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign UP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () async {
                ref.read(authStateNotiProvider.notifier).setAuthenticated(true);
              },
              child: const Text('Sign UP'),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                context.goNamed(RouterNames.signin);
              },
              child: const Text('Already a member? Sign IN!'),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                context.goNamed(RouterNames.second);
              },
              child: const Text('Second'),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                context.go('/noWhere');
              },
              child: const Text('No Where'),
            ),
          ],
        ),
      ),
    );
  }
}
