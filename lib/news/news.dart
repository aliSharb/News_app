import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=1459dcab9f8a4786912f575a2f5eafd1

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getScience()
        ..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News',
              ),
              // actions: [

              //   IconButton(
              //       onPressed: () {
              //         NewsCubit.get(context).changeMode();
              //       },
              //       icon: Icon(Icons.brightness_4_outlined)),
              // ],
            ),
            body: cubit.screens[cubit.currentIndix],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavItem,
              currentIndex: cubit.currentIndix,
              onTap: (index) {
                cubit.setCurrentIndix(index);
              },
            ),
          );
        },
      ),
    );
  }
}
