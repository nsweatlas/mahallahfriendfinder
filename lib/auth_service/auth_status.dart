import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/firebase_settings.dart';
import '../models/member_profile.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
  checking,
  memberProfile,
  memberHome,
}

class AuthenticationStatus extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ApplicationLoginState loginState = ApplicationLoginState.checking;
  User? _userProfile;
  User? get userProfile => _userProfile;

  late MemberProfile? _memberProfile;
  MemberProfile? get memberProfile => _memberProfile;

  AuthenticationStatus() {
    _firebaseAuth.userChanges().listen(
      (User? user) async {
        if (user == null) {
          loginState = ApplicationLoginState.checking;
        } else {
          _userProfile = user;
          _memberProfile = await getMemberProfile(user.uid);
          bool? isComplete = false;
          if (_memberProfile != null) {
            isComplete = (_memberProfile!.isComplete == true) ? true : false;
          }

          loginState = (isComplete)
              ? ApplicationLoginState.memberHome
              : ApplicationLoginState.memberProfile;

          // if (kDebugMode) {
          //   print('User is signed in!');
          //   print('++++++++++++++++++++++++++++++++++++++++++++++++++');
          //   print('From Authentication User [] {$user}');
          //   print('++++++++++++++++++++++++++++++++++++++++++++++++++');
          //   // getUserProfile();
          // }
        }
        notifyListeners();
      },
    );
  }

  Future<dynamic> updateDisplayName(String newDisplayName,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await _userProfile?.updateDisplayName(newDisplayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<MemberProfile?> getMemberProfile(String usrId) async {
    MemberProfile? member;
    await membersProfileRef
        .doc(usrId)
        .get()
        .then((DocumentSnapshot<MemberProfile> memberData) {
      member = memberData.data();
    });
    return Future.value(member);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
