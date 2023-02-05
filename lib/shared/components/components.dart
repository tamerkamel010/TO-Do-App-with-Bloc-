import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../To_Do/To_Do_cubit/to_do_cubit.dart';
Widget defaultTextField(
        {
        required TextEditingController Controller,
        required IconData icon_1,
        required String text,
        required Function validate,
        bool ispassword = false,
        Function? suffix_1}) =>
    TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon_1),
          suffixIcon: ispassword
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: (){
                    suffix_1;
                  },
                )
              : null,

          ///icon next to the tff but the prefix is inside it
          labelText: text),
      validator: (s){
        validate(s!);
      },
      controller: Controller,
      obscureText: ispassword,
    );

///questions
///difference between TextFormField and textfield ?
///how to paint the border of the widget?
Widget defaultButton({
  double height = 50,
  double width = double.infinity,
  Color background = Colors.deepPurple,
  double radius = 5,
  bool IsUpper = true,
  required String text,
  Color text_color = Colors.white,
  double text_size = 20,
  required Function function,

}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          IsUpper ? text.toUpperCase() : text,
          style: TextStyle(
              color: text_color,
              fontSize: text_size,
              fontWeight: FontWeight.bold),
        ),
        onPressed: (){
          function;
        },
      ),
    );

Widget newTFF({
  required TextEditingController textcontroller,
  bool visiable_off = false,
  Function? showPicker,
  bool suffix = false,
  IconData? TF_Icon = Icons.email,
  required TextInputType Keyboard_typing,
  String? label,
}) =>TextFormField(
  onTap: (){
    showPicker;
  },
  obscureText: visiable_off,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(TF_Icon),
    suffixIcon: suffix
        ? IconButton(
      icon: visiable_off
          ? const Icon(Icons.visibility)
          : const Icon(
        Icons.visibility_off,
        color: Colors.redAccent,
      ),
      onPressed: (){
        showPicker;
      },
    )
        : null,
    border: const OutlineInputBorder(),
  ),
  validator: (String? value){
    if(value!.isEmpty){
      return "required";
    }
    return null;
  },

  keyboardType:Keyboard_typing ,
);
Widget buildItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed:(direction) {
    To_Do_cubit.get(context).DeleteItem(id: model['id']);
  },
  child:Container(

    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),

    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
           CircleAvatar(
            radius: 35,
            backgroundColor: Colors.deepPurple,
            child: Text("${model['time']}",

              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),

            ),

          ),

          const SizedBox(

            width: 15,

          ),

          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Text(model['name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),maxLines: 1,overflow: TextOverflow.ellipsis,),

                Text(model['date'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),





              ],

            ),

          ),

          const Spacer(),

          IconButton(

              padding: EdgeInsets.zero,

              onPressed: (){

            To_Do_cubit.get(context).update(status: 'done', id: model['id']);

          }, icon:const Icon(Icons.check_box,color: Colors.lightGreenAccent,)),

          IconButton(

              padding: EdgeInsets.zero,

              onPressed: (){

            To_Do_cubit.get(context).update(status: 'archived', id: model['id']);

          }, icon:const Icon(Icons.archive_outlined,color: Colors.black38)),





        ],

      ),

    ),

  ),
);

Widget TFF({required TextEditingController tc,Function? tap,})=> TextFormField(
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
  ),
  controller: tc,
  onTap: (){
    tap;
  },


);
Widget BuildTasks({required List<Map> tasks,required BuildContext context}) => ConditionalBuilder(
  condition:tasks.isNotEmpty,
  builder: (context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index){
        return buildItem(tasks[index],context);
      },
      itemCount: tasks.length,
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
///iconbutton
///onpressed --->convert icon to another
///          --->show password
///
