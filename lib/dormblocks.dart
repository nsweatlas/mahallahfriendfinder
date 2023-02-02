import 'dorm.dart';
import 'room.dart';

class DormBlock {
  String _blockName = '';
  final Dorm dorm;
  List<Room> _roomList = [];

  DormBlock.name({String? blockName, required this.dorm});
  // DormBlock.name({required _dormName});
  // DormBlock.list(String blockName, Dorm dorm, List<Room> roomList);

  void setBlockName(String blockName) {
    _blockName = blockName;
  }

  String getBlockName() {
    return _blockName;
  }

  void setRoomList(List<Room> roomList) {
    _roomList = roomList;
  }

  List<Room> getRoomList() {
    return _roomList;
  }
}
