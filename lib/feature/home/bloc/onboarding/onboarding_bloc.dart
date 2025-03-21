import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState(0)) {
    on<NextPageEvent>((event, emit) {
      emit(OnboardingState(state.currentPage + 1));
    });

    on<PreviousPageEvent>((event, emit) {
      emit(OnboardingState(state.currentPage > 0 ? state.currentPage - 1 : 0));
    });
  }
}
