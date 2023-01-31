import 'package:mahallahfriendfinder/room.dart';

class Student {
  int matricNum;
  String name;
  String gender;
  int phoneNum;
  Room roomNum;

  Student(
      {required this.matricNum,
      required this.name,
      required this.gender,
      required this.phoneNum,
      required this.roomNum});

  void setMatricNum(int matricNum) {
    this.matricNum = matricNum;
  }
}
