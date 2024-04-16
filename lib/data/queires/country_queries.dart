const String countriesQuery = '''query {
  countries {
   code
    name
    capital
    emoji
    phone
    continent{
      name
    }
  }
}''';

String getCountryQueryByName(String query) {
  return """query CountriesByName {
  countries(filter: { name: { in: ["$query"] } }) {
    code
    name
    capital
    emoji
    phone
    continent{
      name
    }
  }
}""";
}

String getCountryQueryByContinent(String query) {
  return '''query CountriesByContinent {
  countries(filter: { continent: { in: ["$query"] } }) {
    code
    name
    capital
    emoji
    phone
    continent{
      name
    }
  }
}''';
}
