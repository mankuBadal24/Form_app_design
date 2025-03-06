import 'package:flutter/material.dart';
import 'package:photo_check/LoginScreen.dart';
import 'package:photo_check/dashboard.dart';
import 'package:photo_check/shared%20Prefrences/Sharedprefrences.dart';

bool loggedInFlag=false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Map<String,String?> sessionData;
  UserSharedPreferences userSharedPreferences=UserSharedPreferences();
  sessionData=await userSharedPreferences.loadUserData();
  print('session $sessionData');

  if(sessionData['isLoggedIn']!=null){
    loggedInFlag=true;
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loggedInFlag? DashboardScreen() : LoginScreen(),
    );
  }
}
