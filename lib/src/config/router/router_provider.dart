import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router_names.dart';
import 'auth_state_provider.dart';
import '../../pages/signup_page.dart';
import '../../pages/signin_page.dart';
import '../../pages/first_page.dart';
import '../../pages/first_details_page.dart';
import '../../pages/second_page.dart';
import '../../pages/second_details_page.dart';
import '../../pages/third_page.dart';
import '../../pages/third_details_page.dart';
import '../../pages/page_not_found.dart';

import '../../pages/scaffold_with_navbar.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateNotiProvider);

  return GoRouter(
    navigatorKey: _navigatorKey,
    redirect: (context, state) {
      // GoRouter 의 state 가 변할 때마다 호출됨.
      final authenticated = authState; // 특히 authState 변화 시
      // final tryingSignin = state.matchedLocation == '/signin';
      // final tryingSignup = state.matchedLocation == '/signup';
      final tryingSignin = state.matchedLocation == RouterNames.signin;
      final tryingSignup = state.matchedLocation == RouterNames.signup;
      final authenticating = tryingSignin || tryingSignup;

      if (authenticated && tryingSignin) {
        return RouterNames.first;
      }

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
                      parentNavigatorKey: _navigatorKey, // 일반 GoRouter 적용
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
                path: '/third', // route 시작이라서 '/' 으로 시작함.
                name: RouterNames.third,
                builder: (context, state) => const ThirdPage(),
                routes: [
                  GoRoute(
                      path: 'details/:id', // sub route 라서 '/' 으로 시작하지 않음.
                      name: RouterNames.thirdDetails,
                      builder: (context, state) {
                        final id =
                            state.pathParameters['id']!; // pathParameters
                        final firstName =
                            state.uri.queryParameters['firstName'] ??
                                'annoymous';
                        final lastName =
                            state.uri.queryParameters['lastName'] ??
                                'annoymous'; // queryparmaeters
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
