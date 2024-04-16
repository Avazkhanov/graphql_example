import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_example/data/models/country_model.dart';
import 'package:graphql_example/data/network_response.dart';
import 'package:graphql_example/data/queires/country_queries.dart';

class ApiClient {
  ApiClient({required this.graphQLClient});

  factory ApiClient.create() {
    final _httpLink = HttpLink('https://countries.trevorblades.com');
    final link = Link.from([_httpLink]);
    return ApiClient(
      graphQLClient: GraphQLClient(
        link: link,
        cache: GraphQLCache(),
      ),
    );
  }

  final GraphQLClient graphQLClient;

  Future<NetworkResponse> getCountries() async {
    try {
      var result = await graphQLClient.query(
        QueryOptions(document: gql(countriesQuery)),
      );

      if (result.hasException) {
        return NetworkResponse(
            errorText: result.exception!.graphqlErrors.toString());
      } else {
        List<CountryModel> countries = (result.data?['countries'] as List?)
            ?.map((dynamic e) =>
            CountryModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];
        debugPrint("LIST LENGTH:${countries.length}");
        return NetworkResponse(data: countries);
      }
    } catch (error) {
      debugPrint("ERROR:$error");
    }

    return NetworkResponse();
  }

  Future<NetworkResponse> getCountriesByContinents(String continentCode) async {
    try {
      var result = await graphQLClient.query(
        //MutationOptions(document: gql(""))
        QueryOptions(document: gql(getCountryQueryByContinent(continentCode))),
      );

      if (result.hasException) {
        return NetworkResponse(
            errorText: result.exception!.graphqlErrors.toString());
      } else {
        List<CountryModel> countries = (result.data?['countries'] as List?)
            ?.map((dynamic e) =>
            CountryModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];
        debugPrint("LIST LENGTH:${countries.length}");
        return NetworkResponse(data: countries);
      }
    } catch (error) {
      debugPrint("ERROR:$error");
    }

    return NetworkResponse();
  }

  Future<NetworkResponse> getCountriesByName(String name) async {
    try {
      final result = await graphQLClient.query(
        QueryOptions(document: gql(getCountryQueryByName(name))),
      );

      if (result.hasException) {
        final errorText = result.exception!.graphqlErrors.toString();
        return NetworkResponse(errorText: errorText);
      } else {
        final List<CountryModel> country = (result.data?['countries'] as List?)
            ?.map((dynamic e) => CountryModel.fromJson(e as Map<String, dynamic>))
            .toList() ?? [];

        debugPrint("LIST LENGTH: ${country.length}");
        return NetworkResponse(data: country);
      }
    } catch (error) {
      // Handle other errors, e.g., network errors
      debugPrint("ERROR: $error");
      return NetworkResponse(errorText: "An error occurred while fetching countries.");
    }
  }

}