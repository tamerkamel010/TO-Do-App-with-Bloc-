
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/To_Do/screens/new_tasks.dart';
import 'package:to_do_app/To_Do/to_do_cubit/to_do_states.dart';

import '../screens/archived.dart';
import '../screens/deleted.dart';
import '../screens/done.dart';


class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() :super(InitialState());
  //one method one state

  static ToDoCubit get(context) => BlocProvider.of<ToDoCubit>(context);
  ///to_do.dart vars
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ///
  int currentIndex = 0;
  bool isShown = false;
  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks(),
    const Settings(),
  ];
  late Database db;
  List<Map<dynamic,dynamic>>? newTasksList =[];
  List<Map<dynamic,dynamic>>? doneTasks =[];
  List<Map<dynamic,dynamic>>? archivedTasks =[];


  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }
  void createDB(){
    //create db execute just one time.
    //if db is exist ,it display "db opened" ,if not it display db created then db opened
    openDatabase('To_Do_2.db', version: 1, onCreate:(db, version){
      debugPrint("db created");
      db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY,name TEXT,time TEXT,date TEXT ,status TEXT)")
          .then((value) {
        debugPrint("Table created");
      }).catchError((error) {
        debugPrint("error happen while creating the table ${error.toString()}");
      });
    }, onOpen: (db){
      getData(db);
      debugPrint("db opened");
    }).then((value){
      db = value;
      emit(CreateDBState());

    });
  }
  update({required String status,required int id})async{
    db.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]).then((value){
          getData(db);
          emit(UpdateState());

        }
    );
  }
    void getData(db) async{
     db.rawQuery("SELECT * FROM tasks").then((value){
       newTasksList =[];
       doneTasks =[];
       archivedTasks =[];
       value!.forEach((element) {
          if(element['status'] == 'new'){newTasksList!.add(element);}

          else if(element['status'] == 'done'){doneTasks!.add(element);}

          else{archivedTasks!.add(element);}

       });
       emit(GetState());
       //we make emit when the role of method is done
       //after the role of get is done and it is sure because of "then" we emit it not the declare of it.
     }).catchError((error){debugPrint(error.toString());});

  }
  insertIntoDb ({
    required String title,
    required String time,
    required String date,
  }) async {
    await db.transaction((txn) async {
      db.rawInsert('INSERT INTO tasks(name,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value){
        debugPrint('$value is inserted');
        //we use the get after insert immediately
        emit(InsertState());
        getData(db);
      }).catchError((error){debugPrint("$error is happened during inserting");});
       return null;
    });
  }
  //this method used because of the change which happened
void changeFabIcon({required bool isShow}){
    isShown = isShow;
    emit(ChangeBSheetState());
}
void deleteDB(){
     db.delete('tasks').then((value) {
       emit(DeleteState());
       getData(db);

     });

}
void deleteItem({required int id}){
    db.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value){
      getData(db);
      emit(DeleteItemState());
    });
}
}