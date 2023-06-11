import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class EarnipayApp extends StatelessWidget {
  const EarnipayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class AppBuilder extends StatefulWidget {
  const AppBuilder({super.key, this.child});

  final Widget? child;

  @override
  State<AppBuilder> createState() => _AppBuilderState();
}

class _AppBuilderState extends State<AppBuilder> {
  bool? hasInternet;
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    connectionChecker();
    super.initState();
  }

  Future<void> connectionChecker() async {
    streamSubscription = Connectivity().onConnectivityChanged.listen((e) async {
      if (e != ConnectivityResult.none) {
        hasInternet = await InternetConnectionChecker().hasConnection;
      } else {
        hasInternet = await InternetConnectionChecker().hasConnection;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (hasInternet == null)
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (hasInternet ?? false)
          widget.child ?? const SizedBox()
        else
          const NoInternetPage()
      ],
    );
  }
}

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.no_accounts,
              size: 100,
            ),
            Text(
              'No Internet connection',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Please turn on the internet and try again',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
