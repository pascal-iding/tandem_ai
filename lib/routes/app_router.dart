import 'package:go_router/go_router.dart';
import 'package:tandem_ai/features/about/about_screen.dart';
import '../features/chat/presentation/screens/chat_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/chat',
  routes: [
    GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final errorMessage = state.uri.queryParameters['errorMessage'];
        return ProfileScreen(errorMessage: errorMessage);
      },
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) {
        return AboutScreen();
      },
    ),
  ],
);
