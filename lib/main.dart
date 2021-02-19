import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:priceless/auth/google_signin.dart';

import 'auth/signin_page.dart';
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
  await Firebase.initializeApp();

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
    // child: MaterialApp(
    //   title: 'Stock Market App',
    //   theme: ThemeData(brightness: Brightness.dark),
    //   home: StockMarketAppHome(),
    //   // home: Index(),
    //   debugShowCheckedModeBanner: false,
    //   routes: {'/about': (context) => AboutSection()},
    // )));
    child: MyApp(),
  ));
}

String UID;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // _createFolder("Cow Test");
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: SignInPage(),
      routes: {'/about': (context) => AboutSection()},
    );
  }
}

Future<String> _createFolder(String cow) async {
  final folderName = cow;
  final path = Directory("storage/emulated/0/$folderName");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();
    return path.path;
  }
}
