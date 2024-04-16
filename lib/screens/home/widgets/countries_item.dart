import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_example/data/models/country_model.dart';

class CountriesItem extends StatelessWidget {
  const CountriesItem({super.key, required this.countries});

  final List<CountryModel> countries;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var country = countries[index];
        return ListTile(
          title: Text(country.name),
          subtitle: Text(country.capital),
          leading: Text(country.emoji,style: TextStyle(fontSize: 22.sp)),
        );
      },
      separatorBuilder: (context, state) => SizedBox(height: 10.h),
      itemCount: countries.length,
    );
  }
}
