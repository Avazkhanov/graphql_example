import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_example/blocs/country_bloc/country_bloc.dart';

class SelectContinent extends StatefulWidget {
  const SelectContinent({super.key});

  @override
  State<SelectContinent> createState() => _SelectContinentState();
}

class _SelectContinentState extends State<SelectContinent> {
  var currentIndex = 0;
  List<Map<String, String>> continents = [
    {
      'name': 'All',
      'code': 'AS',
    },
    {
      'name': 'Asia',
      'code': 'AS',
    },
    {
      'name': 'Europe',
      'code': 'EU',
    },
    {
      'name': 'North America',
      'code': 'NA',
    },
    {
      'name': 'Oceania',
      'code': 'OC',
    },
    {
      'name': 'South America',
      'code': 'SA',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 1.w, color: Colors.black),
        ),
        child: SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: continents.length,
            itemBuilder: (context, index) {
              if(index == 0){
                return Ink(
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: currentIndex == index ? Colors.blue : Colors.transparent,
                  ),
                  child: InkWell(
                    onTap: () {
                      currentIndex = index;
                      context.read<CountryBloc>().add(FetchCountriesEvent());
                      setState(() {});
                    },
                    child: Center(
                        child: Text(
                          continents[index]['name']!,
                          textAlign: TextAlign.center,
                        )),
                  ),
                );
              }else{
                return Ink(
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: currentIndex == index ? Colors.blue : Colors.transparent,
                  ),
                  child: InkWell(
                    onTap: () {
                      currentIndex = index;
                      context.read<CountryBloc>().add(
                        ChangeContinentEvent(
                            continent: continents[index]['code']!),
                      );
                      setState(() {});
                    },
                    child: Center(
                        child: Text(
                          continents[index]['name']!,
                          textAlign: TextAlign.center,
                        )),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
