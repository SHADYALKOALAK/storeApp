
import 'package:flutter/material.dart';

mixin NavHelper{
  void jump(BuildContext context,Widget to,bool replace){
    if(replace){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => to,));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => to,));
    }

  }

}