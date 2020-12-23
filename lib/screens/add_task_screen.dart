import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add a new Task'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("What need to be done?"),
            gi
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 400,
                    child: TextFormField(
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText:'Enter Task Here',
                        //border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.keyboard_voice)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
