import 'package:bloc/bloc.dart';
import 'package:graphql_example/data/api/api_client.dart';
import 'package:graphql_example/data/models/country_model.dart';
import 'package:graphql_example/data/network_response.dart';
import 'package:meta/meta.dart';

part 'country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc(this.apiClient) : super(CountryInitial()) {
    on<FetchCountriesEvent>(_fetchCountries);
    on<ChangeContinentEvent>(_fetchCountriesByContinent);
    on<FetchCountriesByName>(_getCountryByName);
  }

  void _fetchCountries(FetchCountriesEvent event, emit) async {
    emit(CountryLoading());

    NetworkResponse networkResponse = await apiClient.getCountries();

    if (networkResponse.errorText.isEmpty) {
      emit(CountrySuccess(networkResponse.data as List<CountryModel>));
    } else {
      emit(CountryError(networkResponse.errorText));
    }
  }

  void _fetchCountriesByContinent(ChangeContinentEvent event, emit) async {
    emit(CountryLoading());

    NetworkResponse networkResponse =
        await apiClient.getCountriesByContinents(event.continent);

    if (networkResponse.errorText.isEmpty) {
      emit(CountrySuccess(networkResponse.data as List<CountryModel>));
    } else {
      emit(CountryError(networkResponse.errorText));
    }
  }

  void _getCountryByName(FetchCountriesByName event, emit) async {
    emit(CountryLoading());
    NetworkResponse networkResponse =
        await apiClient.getCountriesByName(event.name);

    if (networkResponse.errorText.isEmpty) {
      emit(CountrySuccess(networkResponse.data as List<CountryModel>));
    } else {
      emit(CountryError(networkResponse.errorText));
    }
  }

  final ApiClient apiClient;
}
