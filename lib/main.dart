import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/cubit.dart';
import 'package:news/shared/main_cubit/app_cubit.dart';
import 'package:news/shared/main_cubit/app_states.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  bool? isDarkModeOn = CacheHelper.getData(key: 'isDarkModeOn');
  DioHelper.init();
  runApp(MyApp(isDarkModeOn!));
}

class MyApp extends StatelessWidget {

  late final bool isDarkModeOn;

  MyApp(this.isDarkModeOn);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessNews()),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(
            savedDarkMode: isDarkModeOn
        ))
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state) => {}  ,
        builder:(context,state) => MaterialApp(
          home: NewsScreen(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.deepOrange,
            appBarTheme:const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                color: Colors.white,
                elevation: 0.0
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 30.0
            ),
            textTheme:const TextTheme(
              bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.deepOrange,
            appBarTheme:const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                color: Colors.black,
                elevation: 0.0
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.white,
                elevation: 30.0
            ),
            textTheme:const TextTheme(
              bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
            ),

          ),
          themeMode: AppCubit.get(context).isDarkModeOn? ThemeMode.dark:ThemeMode.light,
          debugShowCheckedModeBanner: false,
        ) ,
      ),
    );
  }

}

