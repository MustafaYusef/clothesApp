// "proccessing"
// "new"
// "completed"
import 'package:flutter/material.dart';

Color getListColor(String status) {
  if (status == "proccessing") {
    return Colors.amberAccent;
  } else if (status == "new") {
    return Colors.blue;
  } else if (status == "completed") {
    return Colors.green;
  }
}

String getStatus(String status) {
  if (status == "proccessing") {
    return "أنتظار";
  } else if (status == "new") {
    return "جديد";
  } else if (status == "completed") {
    return "مكتمل";
  }
}
