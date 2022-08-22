import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/cubit.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/main_cubit/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearchNews(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppCubit.get(context).isDarkModeOn? Colors.white:Colors.black,
                        ),
                      ),
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: AppCubit.get(context).isDarkModeOn? Colors.white:Colors.black,
                      ),
                      prefixIcon:  Icon(
                        Icons.search,
                        color: AppCubit.get(context).isDarkModeOn? Colors.white:Colors.black,
                      ),
                      border:const  OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(child: buildNewsItems(list)),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
