import 'package:cloud_firestore/cloud_firestore.dart';

class MemberProfile {
  MemberProfile({
    required this.userId,
    required this.isComplete,
    required this.userEmail,
    this.userName,
    this.userMatricNum,
    this.userPhone,
    this.userGender,
    this.userRoomNumber,
    this.userLocation,
  });

  MemberProfile.fromJson(Map<String, Object?> json)
      : this(
          userId: json['userId']! as String,
          isComplete: json['isComplete']! as bool,
          userEmail: json['userEmail']! as String,
          userName: json['userName'] as String?,
          userMatricNum: json['userMatricNum'] as int?,
          userPhone: json['userPhone'] as String?,
          userGender: json['userGender'] as String?,
          userRoomNumber: json['userRoomNumber'] as int?,
          userLocation: json['userLocation'] as GeoPoint?,
        );

  final String userId;
  final bool isComplete;
  final String userEmail;
  final String? userName;
  final int? userMatricNum;
  final String? userPhone;
  final String? userGender;
  final int? userRoomNumber;
  final GeoPoint? userLocation;

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'isComplete': isComplete,
      'userEmail': userEmail,
      'userName': userName,
      'userMatricNum': userMatricNum,
      'userPhone': userPhone,
      'userGender': userGender,
      'userRoomNumber': userRoomNumber,
      'userLocation': userLocation,
    };
  }
}
