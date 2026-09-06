import 'package:flutter/widgets.dart';

/// Typed access to the argument a named route was pushed with.
extension RouteArguments on BuildContext {
  /// The argument passed to `Navigator.pushNamed(..., arguments: value)`.
  ///
  /// Throws a readable error if a route is opened without its argument,
  /// which is otherwise a confusing null-cast failure at build time.
  T routeArgument<T extends Object>() {
    final route = ModalRoute.of(this);
    final argument = route?.settings.arguments;
    if (argument is! T) {
      throw ArgumentError(
        'Route "${route?.settings.name}" expects a $T argument '
        'but received ${argument.runtimeType}.',
      );
    }
    return argument;
  }
}
