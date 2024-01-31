import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/To_Do/to_do_cubit/to_do_cubit.dart';
import 'package:to_do_app/To_Do/to_do_cubit/to_do_states.dart';
import '../../shared/components/components.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context,state) {},
        builder: (context,state) {
          ToDoCubit cubit = ToDoCubit.get(context);
          return ConditionalBuilder(
            condition:cubit.doneTasks!.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return buildItem(cubit.doneTasks![index],context);
                },
                itemCount: cubit.doneTasks!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
            fallback: (context) => const Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu,size: 100,color: Colors.grey),
                    Text('No tasks yet, please add some',style: TextStyle(fontSize: 18,color: Colors.grey ),),
                  ],
                )),
          );
        });
  }
}
//${tasks!.length??10}
