import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entities.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileDataEntity data;
  final bool showBarcode; // Toggle between QR & Barcode on the PVC card

  const ProfileLoaded({
    required this.data,
    this.showBarcode = false,
  });

  ProfileLoaded copyWith({
    ProfileDataEntity? data,
    bool? showBarcode,
  }) {
    return ProfileLoaded(
      data: data ?? this.data,
      showBarcode: showBarcode ?? this.showBarcode,
    );
  }

  @override
  List<Object?> get props => [data, showBarcode];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
