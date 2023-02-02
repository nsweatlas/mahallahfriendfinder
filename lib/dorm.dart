import 'dormblocks.dart';

class Dorm {
  final String dormName;
  List<DormBlock> _dormBlocks = [];

  Dorm.name({required this.dormName});
  Dorm.list({required this.dormName, dBlockList});

  void setDormName(String dormName) {
    dormName = dormName;
  }

  String getDormName() {
    return dormName;
  }

  void setDormBlocks(List<DormBlock> dBlockList) {
    _dormBlocks = dBlockList;
  }

  List<DormBlock> getDormBlocks() {
    return _dormBlocks;
  }
}
