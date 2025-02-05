


import 'package:curso_de_verano/home_screen.dart';
import 'package:curso_de_verano/login_screen.dart';
import 'package:curso_de_verano/signup_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router =  GoRouter(
    initialLocation: LoginScreen.routeName,

    routes: [
      GoRoute(path: LoginScreen.routeName, builder: (context, state) => LoginScreen()),
      GoRoute(path: HomeScreen.routeName, builder: (context, state) => HomeScreen()),
      //Registramos la pantalla de Registro en el GoRouter.
      GoRoute(path: SignUpScreen.routeName, builder: (context, state) => SignUpScreen()),
   ]
  );
}