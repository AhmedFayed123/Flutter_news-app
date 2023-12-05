import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';

import '../component/component.dart';
import '../modules/search/search.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return
       BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
         var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: (){
                      cubit.changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItem,
            ),
          );
        },
      );
  }
}
