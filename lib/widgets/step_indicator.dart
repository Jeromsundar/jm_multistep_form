import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> formNames;
  final Color activeColor;
  final Color inactiveColor;
  final double activeSize;
  final double inactiveSize;
  final Duration animationDuration;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.formNames,
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.grey,
    this.activeSize = 20.0,
    this.inactiveSize = 15.0,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formNames[currentStep], // Display the current step name
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(formNames.length, (index) {
              bool isActive = currentStep == index;
              return Row(
                children: [
                  if (index > 0)
                    AnimatedContainer(
                      duration: animationDuration,
                      width: 30,
                      height: 3,
                      decoration: BoxDecoration(
                        color: index <= currentStep ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TweenAnimationBuilder(
                      duration: animationDuration,
                      tween: Tween<double>(
                          begin: inactiveSize, end: isActive ? activeSize : inactiveSize),
                      builder: (context, double size, child) {
                        return AnimatedContainer(
                          duration: animationDuration,
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive ? activeColor : inactiveColor,
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: activeColor.withOpacity(0.5),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: isActive ? Colors.white : Colors.transparent,
                              size: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
