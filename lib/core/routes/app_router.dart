import 'package:flutter/material.dart';
import 'package:flutter_advanced/core/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/checkout/screens/checkout_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/language/screen/language_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/store/screens/store_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Language Selection
      GoRoute(
        path: '/language',
        name: RouteNames.language,
        builder: (context, state) => const LanguageScreen(),
      ),

      // Dashboard (Nested Navigation Strategy)
      // Usually Dashboard contains Home, Store, Profile via BottomNavBar
      GoRoute(
        path: '/dashboard',
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'home',
            name: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: 'store',
            name: RouteNames.store,
            builder: (context, state) => const StoreScreen(),
          ),
          GoRoute(
            path: 'profile',
            name: RouteNames.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Cart & Checkout
      GoRoute(
        path: '/cart',
        name: RouteNames.cart,
        builder: (context, state) => const CartScreen(),
        routes: [
          GoRoute(
            path: 'checkout',
            name: RouteNames.checkout,
            builder: (context, state) => const CheckoutScreen(),
          ),
        ],
      ),
    ],

    // Global Redirection Logic (e.g., Auth Guards)
    redirect: (context, state) {
      // Example: If not logged in and not on splash, go to login
      // final isLoggedIn = Get.find<AuthController>().isLoggedIn;
      // if (!isLoggedIn && state.matchedLocation != '/') return '/login';
      return null;
    },
  );
}
