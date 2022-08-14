import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/pages.dart';
import 'logic/cubit/account_cubit/account_cubit.dart';
import 'logic/cubit/account_info_cubit/account_info_cubit.dart';
import 'logic/cubit/google_signin_cubit/google_sign_in_cubit.dart';
import 'view/screens/account_screen.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/main_screen.dart';
import 'view/screens/splash_view.dart';
import 'view/screens/welcome_screen.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GoogleSignInCubit(),
            child: const LoginScreen(),
          ),
        );

      case accountScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AccountCubit(),
            child: AccountScreen(),
          ),
        );
      case mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AccountInfoCubit(),
            child: const MainScreen(),
          ),
        );
    }
    return null;
  }
}
