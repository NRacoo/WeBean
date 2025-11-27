import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child:Text(
          "WeBean",
          style:TextStyle(
            color:Colors.black,
            fontSize: 24,
          )
        )
      ),
    );
  }
}