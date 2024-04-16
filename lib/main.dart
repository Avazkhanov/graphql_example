import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_example/blocs/country_bloc/country_bloc.dart';
import 'package:graphql_example/data/api/api_client.dart';
import 'package:graphql_example/screens/home/home_screen.dart';

void main() {
  ApiClient apiClient =
      ApiClient(graphQLClient: ApiClient.create().graphQLClient);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CountryBloc(apiClient)..add(FetchCountriesEvent()))],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
