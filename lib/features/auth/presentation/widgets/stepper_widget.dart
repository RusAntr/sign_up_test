import 'package:flutter/material.dart';
import 'package:sign_up_test/features/auth/presentation/widgets/single_step_widget.dart';

/// Quickly made stepper widget :/
class StepperWidget extends StatefulWidget {
  const StepperWidget({
    super.key,
    required this.currentStep,
  });
  final int currentStep;

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleStepWidget(
          step: 1,
          currentState: widget.currentStep == 1
              ? SingleStepState.inProgress
              : SingleStepState.completed,
        ),

        /// Divider
        Container(
          width: 45,
          height: 1,
          color: Theme.of(context).colorScheme.errorContainer,
        ),
        SingleStepWidget(
          step: 2,
          currentState: widget.currentStep == 2
              ? SingleStepState.inProgress
              : widget.currentStep > 2
                  ? SingleStepState.completed
                  : SingleStepState.future,
        ),

        /// Divider
        Container(
          width: 45,
          height: 1,
          color: Theme.of(context).colorScheme.errorContainer,
        ),
        SingleStepWidget(
          step: 3,
          currentState: widget.currentStep == 3
              ? SingleStepState.inProgress
              : widget.currentStep > 3
                  ? SingleStepState.completed
                  : SingleStepState.future,
        ),
      ],
    );
  }
}
