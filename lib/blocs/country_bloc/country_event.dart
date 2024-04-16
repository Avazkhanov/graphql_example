part of 'country_bloc.dart';

@immutable
sealed class CountryEvent {}

class FetchCountriesEvent extends CountryEvent{}

class ChangeContinentEvent extends CountryEvent{
  final String continent;
  ChangeContinentEvent({required this.continent});
}

class  FetchCountriesByName extends CountryEvent{
  final String name;
  FetchCountriesByName({required this.name});
}