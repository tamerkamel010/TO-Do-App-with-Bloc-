import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../To_Do/to_do_cubit/to_do_cubit.dart';

Widget defaultTextField(
        {required TextEditingController controller,
        required IconData icon_1,
        required String text,
        required Function validate,
        bool isPassword = false,
        Function? suffix_1}) =>
    TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon_1),
          suffixIcon: isPassword
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    suffix_1;
                  },
                )
              : null,

          ///icon next to the tff but the prefix is inside it
          labelText: text),
      validator: (s) {
        validate(s!);
        return null;
      },
      controller: controller,
      obscureText: isPassword,
    );

///questions
///difference between TextFormField and text field ?
///how to paint the border of the widget?
Widget defaultButton({
  double height = 50,
  double width = double.infinity,
  Color background = Colors.deepPurple,
  double radius = 5,
  bool isUpper = true,
  required String text,
  Color textColor = Colors.white,
  double textSize = 20,
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
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          function;
        },
      ),
    );

Widget newTFF({
  required TextEditingController textController,
  bool visableOff = false,
  Function? showPicker,
  bool suffix = false,
  IconData? textFieldIcon = Icons.email,
  required TextInputType keyboardTyping,
  String? label,
}) =>
    TextFormField(
      onTap: () {
        showPicker;
      },
      obscureText: visableOff,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(textFieldIcon),
        suffixIcon: suffix
            ? IconButton(
                icon: visableOff
                    ? const Icon(Icons.visibility)
                    : const Icon(
                        Icons.visibility_off,
                        color: Colors.redAccent,
                      ),
                onPressed: () {
                  showPicker;
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: keyboardTyping,
    );

Widget buildItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        ToDoCubit.get(context).deleteItem(id: model['id']);
      },
      child: Container(
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
                child: Text(
                  "${model['time']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
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
                    Text(
                      model['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      model['date'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ToDoCubit.get(context)
                        .update(status: 'done', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.check_box,
                    color: Colors.lightGreenAccent,
                  )),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ToDoCubit.get(context)
                        .update(status: 'archived', id: model['id']);
                  },
                  icon: const Icon(Icons.archive_outlined,
                      color: Colors.black38)),
            ],
          ),
        ),
      ),
    );

Widget customTextFormField({
  required TextEditingController tc,
  Function? tap,
}) =>
    TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      controller: tc,
      onTap: () {
        tap;
      },
    );

Widget buildTasks({required List<Map> tasks, required BuildContext context}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildItem(tasks[index], context);
          },
          itemCount: tasks.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
      fallback: (context) => const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu, size: 100, color: Colors.grey),
          Text(
            'No tasks yet, please add some',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      )),
    );

///icon button
///on pressed --->convert icon to another
///          --->show password
///
