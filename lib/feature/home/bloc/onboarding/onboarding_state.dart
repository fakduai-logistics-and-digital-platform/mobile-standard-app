import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPage;

  const OnboardingState(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
