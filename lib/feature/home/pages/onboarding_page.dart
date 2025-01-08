import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/feature/home/bloc/onboarding/onboarding_bloc.dart';
import 'package:mobile_app_standard/feature/home/bloc/onboarding/onboarding_event.dart';
import 'package:mobile_app_standard/feature/home/bloc/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  final List<String> pages = [
    "Welcome to the app!",
    "Track your progress.",
    "Achieve your goals!"
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      pages[state.currentPage],
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: state.currentPage > 0
                          ? () => context
                              .read<OnboardingBloc>()
                              .add(PreviousPageEvent())
                          : null,
                      child: const Text("Previous"),
                    ),
                    ElevatedButton(
                      onPressed: state.currentPage < pages.length - 1
                          ? () => context
                              .read<OnboardingBloc>()
                              .add(NextPageEvent())
                          : null,
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
