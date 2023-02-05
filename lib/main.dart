import 'package:to_do_app/shared/components/Bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/To_Do/To_Do.dart';
void main(){
  Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(
    home: To_Do(),
    theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
              color: Colors.black
          ),
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
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
