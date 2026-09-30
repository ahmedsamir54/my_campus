import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../domain/usecases/get_onboarding_items_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingItemsUseCase getOnboardingItemsUseCase;
  final CompleteOnboardingUseCase completeOnboardingUseCase;

  OnboardingCubit({
    required this.getOnboardingItemsUseCase,
    required this.completeOnboardingUseCase,
  }) : super(const OnboardingState());

  Future<void> loadOnboarding() async {
    final result = await getOnboardingItemsUseCase(const NoParams());
    result.fold(
      (failure) => null,
      (items) => emit(state.copyWith(items: items)),
    );
  }

  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<void> completeOnboarding() async {
    await completeOnboardingUseCase(const NoParams());
    emit(state.copyWith(isCompleted: true));
  }

  Future<void> skipOnboarding() async {
    await completeOnboarding();
  }
}
