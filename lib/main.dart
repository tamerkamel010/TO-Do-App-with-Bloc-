import 'package:to_do_app/shared/components/Bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'To_Do/splash_screen.dart';
void main(){
  Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(
    home: const SplashScreen(),
    theme: ThemeData(
      fontFamily: "kindness",
      useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme : IconThemeData(
              color: Colors.deepOrange
          ),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.deepPurple,
            statusBarIconBrightness: Brightness.dark,
          ),
          color: Colors.white,
          elevation: 0.0,

        )
    ),
    darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey
    ),
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
  ));

}
