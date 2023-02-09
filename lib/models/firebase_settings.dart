import 'package:cloud_firestore/cloud_firestore.dart';
import 'member_profile.dart';

final membersProfileRef = FirebaseFirestore.instance
    .collection('membersProfile')
    .withConverter<MemberProfile>(
      fromFirestore: (snapshot, _) => MemberProfile.fromJson(snapshot.data()!),
      toFirestore: (membersProfile, _) => membersProfile.toJson(),
    );
