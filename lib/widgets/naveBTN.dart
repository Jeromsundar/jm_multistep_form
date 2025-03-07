import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final int currentStep;
  final int totalSteps; // Make it dynamic
  final Function(int) onStepChange; // Callback for changing the step
  final VoidCallback onSubmit; // Callback for submitting the form
  final Color buttonColor;
  final Color textColor;
  final bool isNextDisabled;
  final bool isPrevDisabled;

  const NavigationButtons({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.onStepChange,
    required this.onSubmit,
    this.buttonColor = const Color.fromARGB(255, 112, 162, 249),
    this.textColor = Colors.white,
    this.isNextDisabled = false,
    this.isPrevDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous Button (Only visible if currentStep > 0)
          if (currentStep > 0)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isPrevDisabled ? 0.5 : 1.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: isPrevDisabled ? null : () => onStepChange(currentStep - 1),
                child: Text(
                  "Previous",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 75,),
          // Next or Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
            ),
            onPressed: isNextDisabled
                ? null
                : () {
                    if (currentStep < totalSteps - 1) {
                      onStepChange(currentStep + 1);
                    } else {
                      onSubmit();
                    }
                  },
            child: Text(
              currentStep == totalSteps - 1 ? "Submit" : "Next",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
