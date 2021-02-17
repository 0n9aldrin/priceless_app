import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priceless/auth/google_signin.dart';

import 'index.dart';
import 'stocks/bloc/news/news_bloc.dart';
import 'stocks/bloc/portfolio/portfolio_bloc.dart';
import 'stocks/bloc/profile/profile_bloc.dart';
import 'stocks/bloc/search/search_bloc.dart';
import 'stocks/bloc/sector_performance/sector_performance_bloc.dart';
import 'stocks/widgets/about/about.dart';
import 'stocks/widgets/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioBloc>(
          create: (context) => PortfolioBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<SectorPerformanceBloc>(
          create: (context) => SectorPerformanceBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Stock Market App',
        theme: ThemeData(brightness: Brightness.dark),
        home: StockMarketAppHome(),
        // home: Index(),
        debugShowCheckedModeBanner: false,
        routes: {'/about': (context) => AboutSection()},
      )));
}
