import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view_models/cubit/states.dart';
import 'package:bloc/bloc.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

}