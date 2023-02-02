import 'package:mahallahfriendfinder/dorm.dart';
import 'package:mahallahfriendfinder/dormblocks.dart';
import 'package:mahallahfriendfinder/room.dart';

class Student {
  int matricNum;
  String name;
  int phoneNum;
  Room roomNum;
  String room;
  DormBlock dormblock;
  Dorm dorm;

  Student({
    required this.matricNum,
    required this.name,
    required this.phoneNum,
    required this.roomNum,
    required this.room,
    required this.dormblock,
    required this.dorm,
  });

  void setMatricNum(int matricNum) {
    this.matricNum = matricNum;
  }

  int getMNum() {
    return matricNum;
  }

  void setName(int matricNum) {
    this.matricNum = matricNum;
  }

  String getName() {
    return name;
  }

  void setPonNum(int phoneNum) {
    this.matricNum = phoneNum;
  }

  int getPonNum() {
    return phoneNum;
  }

  void setRoomNum(int roomNum) {
    this.matricNum = roomNum;
  }

  Room getRoomNum() {
    return roomNum;
  }

  void setRoom() {
    this.room = room;
  }

  DormBlock getDormBlock() {
    return dormblock;
  }

  void setDormBlock() {
    this.dormblock = dormblock;
  }

  Dorm getDorm() {
    return dorm;
  }

  void setDorm() {
    this.dorm = dorm;
  }
}
