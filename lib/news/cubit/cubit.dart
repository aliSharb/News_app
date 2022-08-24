import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/cubit/states.dart';

import '../../medules/businese/BusineseScreen.dart';
import '../../medules/sciences/SciencesScreen.dart';
import '../../medules/sports/SportsScreen.dart';
import '../../network/remote/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndix = 0;
  List<BottomNavigationBarItem> bottomNavItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded), label: 'Science'),
  ];
  void setCurrentIndix(int index) {
    currentIndix = index;
    if (currentIndix == 1) getSports();
    if (currentIndix == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusineseScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '1459dcab9f8a4786912f575a2f5eafd1',
    }).then((value) {
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('eeeeeeeeeeeeeeeeeeeee' + error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];
  void getSports() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apikey': '1459dcab9f8a4786912f575a2f5eafd1',
    }).then((value) {
      Sports = value?.data['articles'];
      print(Sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('eeeeeeeeeeeeeeeeeeeee' + error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apikey': '1459dcab9f8a4786912f575a2f5eafd1',
    }).then((value) {
      science = value?.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('eeeeeeeeeeeeeeeeeeeee' + error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  bool isDark = false;
  void changeMode() {
    if (isDark == false) {
      isDark = true;
      emit(NewsLightModeState());
    } else {
      isDark = false;
      emit(NewsNightModeState());
    }
  }
}
