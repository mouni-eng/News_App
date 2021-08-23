import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';
import 'package:news_app/services/cash_helper.dart';
import 'package:news_app/services/dio_helper.dart';
import 'package:news_app/view_models/cubit/states.dart';
import 'package:bloc/bloc.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(NewsBottomNavigationBarState());
  }

  void getThemeMode() {
    bool? fromSharedBool = CashHelper.getBool(key: "isDark");
    if(fromSharedBool != null) {
      isDark = fromSharedBool;
      emit(NewsThemeModeState());
    }
  }

  void changeThemeMode() {
      isDark = !isDark;
      CashHelper.setBool(key: "isDark", value: isDark).then((value) => emit(NewsThemeModeState()));
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "business"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "science"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "sports"),
  ];

  List<dynamic> business = [];
  
  Future<void> getBusiness() async{
    emit(NewsLoadingState());
    await DioHelper.getData(url: "v2/top-headlines", query:
    { "country" : "eg",
      "category" : "business",
      "apiKey" : "02a31838831b46369f46a42532baae3a",
    }
    ).then((value) {
      business = value.data["articles"];
      print(business[0].toString());
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState());
    });
  }

  List<dynamic> science = [];

  Future<void> getScience() async{
    emit(NewsLoadingState());
    await DioHelper.getData(url: "v2/top-headlines", query:
    { "country" : "eg",
      "category" : "science",
      "apiKey" : "02a31838831b46369f46a42532baae3a",
    }
    ).then((value) {
      science = value.data["articles"];
      print(science[0].toString());
      emit(NewsScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsScienceErrorState());
    });
  }

  List<dynamic> sports = [];

  Future<void> getSports() async{
    emit(NewsLoadingState());
    await DioHelper.getData(url: "v2/top-headlines", query:
    { "country" : "eg",
      "category" : "sports",
      "apiKey" : "02a31838831b46369f46a42532baae3a",
    }
    ).then((value) {
      sports = value.data["articles"];
      print(sports[0].toString());
      emit(NewsSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState());
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsLoadingState());
    DioHelper.getData(url: "v2/everything", query:
    { "q" : value,
      "apiKey" : "02a31838831b46369f46a42532baae3a",
    }
    ).then((value) {
      search = value.data["articles"];
      print(search[0].toString());
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState());
    });
  }

}