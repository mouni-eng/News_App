import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view_models/cubit/cubit.dart';
import 'package:news_app/view_models/cubit/states.dart';
import 'package:news_app/widgets/components.dart';
class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  validate: (value) {
                    if(value!.isEmpty) {
                      return "please enter search keywords";
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  type: TextInputType.text,
                  onChange: (value) {
                    cubit.getSearch(value);
                  },
                  label: "Search",
                ),
              ),
              Expanded(child: buildArticleScreen(cubit.search, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}