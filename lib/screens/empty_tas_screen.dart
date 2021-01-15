import 'package:flutter/material.dart';

import 'add_task_screen.dart';
//import 'package:todo_list/screens/add_task_screen.dart';

class EmptyTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your task',style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/empty_task.png",
              height:deviceSize.height *0.29,
              width: deviceSize.width * 0.29 ,
            ),
            SizedBox(height: 8.0, width: 8.0),
            Text(
              "You don't have any task yet",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "Click here to add a new task",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 16.0, width: 16.0),
          ],
        ),
      ),
    );
    ;
  }
}
