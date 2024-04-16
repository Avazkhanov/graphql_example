import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_example/blocs/country_bloc/country_bloc.dart';
import 'package:graphql_example/screens/home/widgets/countries_item.dart';
import 'package:graphql_example/screens/home/widgets/select_contient.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(width: 10.w),
          const Spacer(),
          SizedBox(
            width: 300.w,
            child: TextField(
              onChanged: (v) {
                if (v.isEmpty) {
                  context.read<CountryBloc>().add(FetchCountriesEvent());
                } else {
                  context
                      .read<CountryBloc>()
                      .add(FetchCountriesByName(name: v));
                }
              },
              decoration: InputDecoration(
                hintText: "Search",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(color: Colors.black, width: 1.w)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(color: Colors.black, width: 1.w)),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          const SelectContinent(),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<CountryBloc, CountryState>(
              builder: (context, state) {
                if (state is CountryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CountrySuccess) {
                  return CountriesItem(countries: state.countries);
                }
                return const SizedBox(child: Text("Error"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
