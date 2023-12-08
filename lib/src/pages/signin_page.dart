import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/router/auth_state_provider.dart';
import '../config/router/router_names.dart';

class SigninPage extends ConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign IN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).setAuthenticated(true);
              },
              child: const Text('Sign IN'),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                GoRouter.of(context).goNamed(RouterNames.signup);
              },
              child: const Text('Not a member? Sign UP!'),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                context.goNamed(RouterNames.first);
              },
              child: const Text('First'),
            ),
          ],
        ),
      ),
    );
  }
}
