import 'package:flutter/material.dart';

import 'add_task_screen.dart';

class EmptyTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                height: 100,
                width: 100,
            ),
            SizedBox(height: 8.0, width: 8.0),
            Text(
              "You don't have any Todo yet",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "Click here to add a new Todo ",
            //style: Theme.of(context).textTheme.caption,
              style: TextStyle(
                color: Colors.black
              ),
            ),
            SizedBox(height: 16.0, width: 16.0),
          ],
        ),
      ),
    );


  }
}
