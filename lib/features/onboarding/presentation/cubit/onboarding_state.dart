import 'package:equatable/equatable.dart';
import '../../domain/entities/onboarding_item.dart';

class OnboardingState extends Equatable {
  final List<OnboardingItem> items;
  final int currentIndex;
  final bool isCompleted;

  const OnboardingState({
    this.items = const [],
    this.currentIndex = 0,
    this.isCompleted = false,
  });

  bool get isLastPage => items.isNotEmpty && currentIndex == items.length - 1;

  OnboardingState copyWith({
    List<OnboardingItem>? items,
    int? currentIndex,
    bool? isCompleted,
  }) {
    return OnboardingState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [items, currentIndex, isCompleted];
}
