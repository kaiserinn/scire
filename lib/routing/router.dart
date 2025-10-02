import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scire/routing/routes.dart";
import "package:scire/ui/auth/auth_viewmodel.dart";
import "../ui/auth/auth_screen.dart";
import "../ui/onboarding/onboarding_screen.dart";
import "../ui/home/home_screen.dart";

final router = GoRouter(
  initialLocation: Routes.onboarding,
  routes: [
    GoRoute(
      name: "home",
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: "onboarding",
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: "auth",
      path: Routes.auth,
      builder: (context, state) => AuthScreen(
        viewModel: AuthViewModel(authRepository: context.read())
      ),
    ),
  ],
);
