import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverod_gorouter/src/config/router/auth_state_provider.dart';

import '../config/router/router_names.dart';

class ThirdPage extends ConsumerWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Third Page'),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                GoRouter.of(context).goNamed(
                  RouterNames.thirdDetails,
                  pathParameters: {'id': '2'},
                  queryParameters: {'firstName': 'John'},
                );
              },
              child: const Text('View Third Details'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // 인증된 사용자가 signin 을 선택하면 first 로 이동
                context.goNamed(RouterNames.signin);
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).setAuthenticated(false);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
