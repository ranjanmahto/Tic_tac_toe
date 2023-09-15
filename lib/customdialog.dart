import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final content;
 final VoidCallback callback;

  const CustomDialog({required this.title,required this.content,required this.callback,super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      content: Text(content,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
      actions: <Widget>[
        SizedBox(
            width: 60,
          child: TextButton(onPressed: callback, child: Text('Reset',style: TextStyle(color: Colors.blue[400],fontSize: 17),
          
          ))
           
          )
      ],
    );
  }
}