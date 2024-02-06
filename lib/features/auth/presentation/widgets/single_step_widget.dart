import 'package:flutter/material.dart';
import 'package:sign_up_test/config/sign_up_test_app_icons.dart';

/// Defines possible step states
enum SingleStepState {
  completed,
  inProgress,
  future,
}

class SingleStepWidget extends StatelessWidget {
  const SingleStepWidget({
    super.key,
    required this.step,
    required this.currentState,
  });
  final int step;
  final SingleStepState currentState;

  /// Completed step
  Widget completed(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.surface),
      ),
      child: Icon(
        SignUpTestAppIcons.done,
        size: 12,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  /// Current step
  Widget inProgress(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  /// Step ahead
  Widget future(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case SingleStepState.completed:
        return completed(context);
      case SingleStepState.inProgress:
        return inProgress(context);
      case SingleStepState.future:
        return future(context);
      default:
        return const SizedBox.shrink();
    }
  }
}
