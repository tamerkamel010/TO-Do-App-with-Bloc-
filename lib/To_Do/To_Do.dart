import 'package:to_do_app/To_Do/To_Do_cubit/to_do_cubit.dart';
import 'package:to_do_app/To_Do/To_Do_cubit/to_do_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class To_Do extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //".." mean that it save the cubit in var and use method from it by the second dot
      create: (BuildContext context)=> To_Do_cubit()..createDB(),
      child :BlocConsumer<To_Do_cubit,to_do_states>(
        listener: (BuildContext context,to_do_states state){
          if(state is InsertState){
            Navigator.pop(context);
            timeController.text ='';
            titleController.text ='';
            dateController.text='';
          }
        },
        builder: (BuildContext context ,to_do_states state){
          To_Do_cubit cubit = To_Do_cubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                automaticallyImplyLeading: false,
                title: const Text(
                  "ToDo App",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: (){ cubit.DeleteDB();}, icon: const Icon(Icons.delete)),
                ],
              ),
              body: Container(
                child: To_Do_cubit.get(context).screens[cubit.currentIndex],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                child: cubit.isShown ? const Icon(Icons.add) : const Icon(Icons.edit),
                onPressed: () {
                  if (cubit.isShown) {
                    if(formKey.currentState!.validate())
                    {
                      print("validated");
                      cubit.insertIntoDb(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text);
                      cubit.ChangefabIcon(isshow: false);
                    }else{
                      print("not validated");
                    }
                  } else {
                    scaffoldKey.currentState?.showBottomSheet((context) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //title ttf
                                  TextFormField(
                                    controller: titleController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Task title",
                                      prefixIcon: Icon(Icons.title),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ///time Textfield
                                  TextFormField(
                                    controller: timeController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Task time",
                                      prefixIcon: Icon(Icons.watch_later_outlined),
                                    ),
                                    keyboardType: TextInputType.none,
                                    onTap: (){
                                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                        timeController.text = value!.format(context).toString();
                                      }).catchError((error){print('$error is happened in time picker');});
                                    },
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'required';
                                      }
                                      return null;
                                    },


                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ///date TextField
                                  TextFormField(
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Task date",
                                      prefixIcon: Icon(Icons.date_range_outlined,),
                                    ),
                                    keyboardType: TextInputType.none,
                                    onTap: (){
                                      showDatePicker(context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2050-12-29')
                                      ).then((value){
                                        dateController.text = DateFormat.yMMMd().format(value!).toString();
                                      }).catchError((error){print("$error is happened in date picker");});
                                    },
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ))
                        .closed.then((value){
                      cubit.ChangefabIcon(isshow: false);
                    });
                    cubit.ChangefabIcon(isshow: true);
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.shifting,
                  unselectedIconTheme: const IconThemeData(size: 25),
                  iconSize: 35,
                  currentIndex: cubit.currentIndex,
                  selectedItemColor: Colors.deepPurple,
                  elevation: 0,
                  unselectedItemColor: Colors.grey,
                  ///index_1 save the value which is changed and put it in index then
                  ///assign the value of index to the current index
                  onTap: (index_1) {
                    cubit.changeIndex(index_1);
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "New"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task_alt_outlined), label: "Done"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive), label: "Archived"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Settings"),
                  ]));
        },

      ),
    );
  }
  /*Future<String> getName() async {
    return "Tamer";
  }*/



}


//1-create db
//2-create tables
//3-open db
//4-insert into db
//5-update db
//6- delete
//7- get from db
//try and catch
/*
try{
var name = await getName();
//await tell that wait to get data from the background and use
//async to open channel in the background for the function

throw('this is error');
//throw make error all code after it not executed
// try and catch "ordering not important" , short processes may be executed before long one.
//try and catch use async and await
}
catch(error){
print(error);
}*/
