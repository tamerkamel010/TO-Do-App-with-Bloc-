import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/To_Do/to_do_cubit/to_do_cubit.dart';
import 'package:to_do_app/To_Do/to_do_cubit/to_do_states.dart';

import '../../shared/components/components.dart';
class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, ToDoStates state) {},
        builder: (context, ToDoStates state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return buildItem(ToDoCubit.get(context).archivedTasks![index],context);
              },
              itemCount: ToDoCubit.get(context).archivedTasks!.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          );
        });
  }
}
/*
Padding(
padding: const EdgeInsets.all(10.0),
child: ListView.separated(
physics: const BouncingScrollPhysics(),
itemBuilder: (context, index){
return buildItem(ToDoCubit.get(context).archivedTasks![index],context);
},
itemCount: ToDoCubit.get(context).archivedTasks!.length,
separatorBuilder: (context, index) {
return const SizedBox(
height: 10,
);
},
),
);*/
