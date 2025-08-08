
import 'package:go_router/go_router.dart';
import '../features/chat/presentation/screens/chat_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/chat',
  routes: [
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatScreen(),
    ),
  ],
);
