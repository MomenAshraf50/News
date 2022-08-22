import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;


  List<BottomNavigationBarItem> bottomNavItems =const [
    BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined), label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_outlined), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];



  void changeBottomNavBar(index){
    currentIndex = index;

    if(index == 1){
      getSportsNews();
    }else if(index == 2){
      getScienceNews();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> businessNews = [];

  void getBusinessNews(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {'country': 'eg',
        'category':'business',
        'apiKey':'cc64bb2eb8ec499789f3c65130c17fb1'}
    ).then((value){
      businessNews=  value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessFailedState(error.toString()));
    });
  }
  List<dynamic> sportsNews = [];

  void getSportsNews(){
    if(sportsNews.isEmpty){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {'country': 'eg',
            'category':'sports',
            'apiKey':'cc64bb2eb8ec499789f3c65130c17fb1'}
      ).then((value){
        sportsNews=  value.data['articles'];
        print(sportsNews);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        emit(NewsGetSportsFailedState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }
  List<dynamic> scienceNews = [];

  void getScienceNews(){
    if(scienceNews.isEmpty){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {'country': 'eg',
            'category':'science',
            'apiKey':'cc64bb2eb8ec499789f3c65130c17fb1'}
      ).then((value){
        scienceNews =  value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceFailedState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search = [];

  void getSearchNews(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':value,
          'apiKey':'cc64bb2eb8ec499789f3c65130c17fb1'}
    ).then((value){
      search =  value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchFailedState(error.toString()));
    });

  }

}