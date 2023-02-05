import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../To_Do_cubit/to_do_cubit.dart';
import '../To_Do_cubit/to_do_states.dart';
class done_tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<To_Do_cubit, to_do_states>(
        listener: (BuildContext context, to_do_states state) {},
        builder: (BuildContext context, to_do_states state) {
          return ConditionalBuilder(
            condition:To_Do_cubit.get(context).donetasks!.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return buildItem(To_Do_cubit.get(context).donetasks![index],context);
                },
                itemCount: To_Do_cubit.get(context).donetasks!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
            fallback: (context) => Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.menu,size: 100,color: Colors.grey),
                    Text('No tasks yet, please add some',style: TextStyle(fontSize: 18,color: Colors.grey ),),
                  ],
                )),
          );
        });
  }
}
//${tasks!.length??10}
