import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverod_gorouter/src/config/router/auth_state_provider.dart';
import 'package:riverod_gorouter/src/pages/first_page.dart';
import 'package:riverod_gorouter/src/pages/page_not_found.dart';
import 'package:riverod_gorouter/src/pages/second_details_page.dart';
import 'package:riverod_gorouter/src/pages/second_page.dart';
import 'package:riverod_gorouter/src/pages/signin_page.dart';
import 'package:riverod_gorouter/src/pages/third_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../pages/first_details_page.dart';
import '../../pages/scaffold_with_navbar.dart';
import '../../pages/signup_page.dart';
import '../../pages/third_details_page.dart';
import 'router_names.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _navigatorKey,
    redirect: (context, state) {
      final authenticated = authState;
      // final tryingSignin = state.matchedLocation == '/signin';
      // final tryingSignup = state.matchedLocation == '/signup';
      final tryingSignin = state.matchedLocation == RouterNames.signin;
      final tryingSignup = state.matchedLocation == RouterNames.signup;
      final authenticating = tryingSignin || tryingSignup;

      if (!authenticated) {
        return authenticating ? null : RouterNames.signin;
      }

      return null; // pass through to original location
    },
    // 경로를 지정하지 않은 authState 의 변화 시 자동으로 지정되는 경로임.
    initialLocation: '/first',
    routes: [
      GoRoute(
        path: '/signin',
        name: RouterNames.signin,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: '/signup',
        name: RouterNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(
            navigationShell: navigationShell,
          ); // shell navBar
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/first',
                name: RouterNames.first,
                builder: (context, state) => const FirstPage(),
                routes: [
                  GoRoute(
                    path: 'details', // ???
                    name: RouterNames.firstDetails,
                    builder: (context, state) => const FirstDetailsPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/second',
                name: RouterNames.second,
                builder: (context, state) => const SecondPage(),
                routes: [
                  GoRoute(
                      path: 'details/:id',
                      name: RouterNames.secondDetails,
                      builder: (context, state) {
                        final id = state.pathParameters['id']!;
                        return SecondDetailsPage(id: id);
                      }),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/third',
                name: RouterNames.third,
                builder: (context, state) => const ThirdPage(),
                routes: [
                  GoRoute(
                      path: 'details/:id',
                      name: RouterNames.thirdDetails,
                      builder: (context, state) {
                        final id = state.pathParameters['id']!;
                        final firstName =
                            state.uri.queryParameters['firstName'] ??
                                'annoymous';
                        final lastName =
                            state.uri.queryParameters['lastName'] ??
                                'annoymous';
                        return ThirdDetailsPage(
                          id: id,
                          firstName: firstName,
                          lastName: lastName,
                        );
                      }),
                ],
              ),
            ],
          ),
        ],
      )
    ],
    errorBuilder: (context, state) => PageNotFound(
      errMsg: state.error.toString(),
    ),
  );
}
