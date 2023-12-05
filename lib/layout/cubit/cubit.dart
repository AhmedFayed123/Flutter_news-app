
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/remote/local/cache.dart';
import 'package:news_app/remote/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItem=[
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ) ,
  ];
  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex=index;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsBottomNavState());
    });
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print('error ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));

    });
  }
  List<dynamic> sports=[];

  void getSports(){
    emit(NewsSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print('error ${error.toString()}');
      emit(NewsGetSportsErrorState(error.toString()));

    });
  }
  List<dynamic> science=[];

  void getScience(){
    emit(NewsScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print('error ${error.toString()}');
      emit(NewsGetScienceErrorState(error.toString()));

    });
  }


  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(NewsChangeAppModeState());

    }else{
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        emit(NewsChangeAppModeState());

      });
    }

  }

  List<dynamic> search=[];
  void getSearch(String value){
    emit(NewsSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print('error ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));

    });
  }


}