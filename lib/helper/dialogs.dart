import 'package:flutter/material.dart';

class Dialogs{
  static void showSnackBar(BuildContext context,String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),
    backgroundColor: const Color.fromARGB(255, 202,109,133),behavior: SnackBarBehavior.floating,));
  }
  static void showProgressBar(BuildContext context){
   showDialog(context: context, builder:(_) => const Center(child: CircularProgressIndicator()));
  }
}