import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view_models/cubit/cubit.dart';
import 'package:news_app/view_models/cubit/states.dart';
import 'package:news_app/widgets/components.dart';
class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.sports;
        return buildArticleScreen(list, context,);
      },
    );
  }
}