part of 'country_bloc.dart';

@immutable
sealed class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryError extends CountryState {
  final String errorMessage;

  CountryError(this.errorMessage);
}

class CountrySuccess extends CountryState {
  final List<CountryModel> countries;

  CountrySuccess(this.countries);
}