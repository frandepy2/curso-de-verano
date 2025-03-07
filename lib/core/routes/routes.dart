import 'package:curso_de_verano/account_screen.dart';
import 'package:curso_de_verano/home_screen.dart';
import 'package:curso_de_verano/launch_screen.dart';
import 'package:curso_de_verano/login_screen.dart';
import 'package:curso_de_verano/navigator_bar.dart';
import 'package:curso_de_verano/selfie_screen.dart';
import 'package:curso_de_verano/signup_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: LaunchScreen.routeName, routes: [
    
    GoRoute(path: LaunchScreen.routeName, builder: (context, state) => LaunchScreen()),
    
    GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => LoginScreen()),
    GoRoute(
      path: NavigatorBar.routeName, builder : (context, state) => NavigatorBar()),
    GoRoute(
        path: HomeScreen.routeName, builder: (context, state) => HomeScreen()),
    //Registramos la pantalla de Registro en el GoRouter.
    GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => SignUpScreen()),

    GoRoute(path: AccountScreen.routeName, builder:  (context, state) => AccountScreen()),
    //Registramos la pantalla de solicitud de Selfie.
    // /selfie/:name/:password/:email/:phone/:birthday:
    GoRoute(
      path: '/selfie',
      builder: (context, state) {

        final name = state.uri.queryParameters['name'];
        final password = state.uri.queryParameters['password'];
        final email = state.uri.queryParameters['email'];
        final phone = state.uri.queryParameters['phone'];
        final birthday = state.uri.queryParameters['birthday'];

        return SelfieScreen(
          name: name!,
          password: password!,
          email: email!,
          phone: phone!,
          birthday: birthday!,
        );
      },
    ),
  ]);
}
