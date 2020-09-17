import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/adminScreens/departmentComplaintDescription.dart';
import 'package:faridabad/adminScreens/adminUI.dart';
import 'package:faridabad/clientScreens/authScreen.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:faridabad/clientScreens/filecomplaint.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:faridabad/clientScreens/previouscomplaints.dart';
import 'package:faridabad/clientScreens/showcomplaintNew.dart';
import 'package:faridabad/clientScreens/splash_screen.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:faridabad/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'data/appTheme.dart';
import './adminScreens/adminProfile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateNotifier>(
          create: (context) => AppStateNotifier(),
        ),
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const routeName = '/myapp';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Samadhaan',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: value.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          home: SplashScreen(),
          routes: {
            ShowComplaintsNew1.routeName: (ctx) => ShowComplaintsNew1(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
            FileComplaint.routeName: (ctx) => FileComplaint(),
            Base.routeName: (ctx) => Base(),
            PreviousComplaints.routeName: (ctx) => PreviousComplaints(),
            ComplaintScreen.routeName: (ctx) => ComplaintScreen(),
            ComplaintDetails.routeName: (ctx) => ComplaintDetails(),
            AdminUi.routeName: (ctx) => AdminUi(),
            ShowComplaintsNew.routeName: (ctx) => ShowComplaintsNew(),
            MyApp.routeName: (ctx) => MyApp(),
            InputData.routeName: (ctx) => InputData(),
            AdminProfile.routename: (ctx) => AdminProfile(),
          },
        );
      },
    );
  }
}

class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;
  var user;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}
