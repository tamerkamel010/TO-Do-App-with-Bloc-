import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../screens/archived.dart';
import '../screens/deleted.dart';
import '../screens/done.dart';
import '../screens/new_tasks.dart';
import 'to_do_states.dart';


class To_Do_cubit extends Cubit<to_do_states> {
  To_Do_cubit() :super(IntialState());
  //one method one state

  static To_Do_cubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool isShown = false;
  List<Widget> screens = [
    newTasks(),
    done_tasks(),
    archived_tasks(),
    Settings(),
  ];
  late Database db;
  List<Map<dynamic,dynamic>>? tasks =[];
  List<Map<dynamic,dynamic>>? new_tasks =[];
  List<Map<dynamic,dynamic>>? donetasks =[];
  List<Map<dynamic,dynamic>>? archivedtasks =[];


  void changeIndex(int index){
    currentIndex = index;
    emit(changeIndexState());
  }
  void createDB(){
    //create db execute just one time.
    //if db is exist ,it display "db opened" ,if not it display db created then db opened
    openDatabase('To_Do_2.db', version: 1, onCreate:(db, version){
      print("db created");
      db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY,name TEXT,time TEXT,date TEXT ,status TEXT)")
          .then((value) {
        print("Table created");
      }).catchError((error) {
        print("error happen while creating the table ${error.toString()}");
      });
    }, onOpen: (db){
      getData(db);
      print("db opened");
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
       new_tasks =[];
       donetasks =[];
       archivedtasks =[];
       value!.forEach((element) {
          if(element['status'] == 'new'){new_tasks!.add(element);}

          else if(element['status'] == 'done'){donetasks!.add(element);}

          else{archivedtasks!.add(element);}

       });
       emit(GetState());
       //we make emit when the role of method is done
       //after the role of get is done and it is sure because of "then" we emit it not the declare of it.
     }).catchError((error){print(error.toString());});

  }
  insertIntoDb ({
    required String title,
    required String time,
    required String date,
  }) async {
    await db.transaction((txn) async {
      db.rawInsert('INSERT INTO tasks(name,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value){
        print('$value is inserted');
        //we use the get after insert immediately
        emit(InsertState());
        getData(db);
      }).catchError((error){print("$error is happened during inserting");});
       return null;
    });
  }
  //this method used because of the change which happened
void ChangefabIcon({required bool isshow}){
    isShown = isshow;
    emit(changeBSheetState());
}
void DeleteDB(){
     db.delete('tasks').then((value) {
       emit(DeleteState());
       getData(db);

     });

}
void DeleteItem({required int id}){
    db.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value){
      getData(db);
      emit(DeleteItemState());
    });
}
}