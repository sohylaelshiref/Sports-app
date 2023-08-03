part of 'all_countries_cubit.dart';

abstract class AllCountriesState {}

class AllCountriesInitial extends AllCountriesState {}

class AllCountriesLoading extends AllCountriesState {}

class AllCountriesSuccess extends AllCountriesState {
  final CountriesApi ourresponse;
  AllCountriesSuccess({required this.ourresponse});
}

class AllCountriesError extends AllCountriesState {}
