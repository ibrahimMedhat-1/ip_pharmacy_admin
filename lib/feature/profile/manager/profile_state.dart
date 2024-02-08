part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileImage extends ProfileState {}

class UpdatePharmacyData extends ProfileState {}

class UpdatePharmacyDataLoading extends ProfileState {}
