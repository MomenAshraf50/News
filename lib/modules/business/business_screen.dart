import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/cubit.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        builder: (context,state)
        {
          var list = NewsCubit.get(context).businessNews;
          return list.isNotEmpty? buildNewsItems(list): const Center(child: CircularProgressIndicator());
        },
        listener: (context,state) {}
    );
  }
}
