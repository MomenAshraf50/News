import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/main_cubit/app_states.dart';
import 'package:news/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDarkModeOn = false;

  void changeAppMode({bool? savedDarkMode}){

    if(savedDarkMode != null){
      isDarkModeOn = savedDarkMode;
      emit(AppChangeModeState());
    }else{
      isDarkModeOn = !isDarkModeOn;
      CacheHelper.putData(key: 'isDarkModeOn', value: isDarkModeOn).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}