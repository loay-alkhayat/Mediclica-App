import 'package:flutter/material.dart';

class Functions {
  static void navigatorPush(BuildContext context, Widget screenNameToNavigate) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // This is the builder for the page content
          return FadeTransition(
            opacity: animation,
            child: Transform.translate(
              offset: Offset(0, animation.value), // Adjust as needed
              child: screenNameToNavigate,
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // This is the builder for the transition animation
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;

          var offsetAnimation = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve))
              .animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static void navigatorPushAndRemove(
      BuildContext context, Widget screenNameToNavigate) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: screenNameToNavigate,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var offsetAnimation = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve))
              .animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }
}
