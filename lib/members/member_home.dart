import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_service/auth_status.dart';
import '../models/firebase_settings.dart';
import '../models/member_profile.dart';
import 'member_information.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({super.key});

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  late MemberProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = context.read<AuthenticationStatus>().memberProfile!;
  }

  getMyRoommateList() {
    List<Widget> children = [];

    return FutureBuilder<QuerySnapshot<MemberProfile>>(
      future: membersProfileRef
          .where('userRoomNumber', isEqualTo: userProfile.userRoomNumber)
          .where('userId', isNotEqualTo: userProfile.userId)
          .get(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'الرجاء الإنتظار...',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ];
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                MemberProfile membersProfile =
                    snapshot.data!.docs[index].data();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberInformation(
                          memInfo: membersProfile,
                        ),
                      ),
                    ),
                    tileColor: Colors.grey.shade100,
                    minVerticalPadding: 5.0,
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 40.0,
                      child: Icon(Icons.person_outline_sharp),
                    ),
                    title: Text(
                      '${membersProfile.userName}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            children = <Widget>[
              const Icon(
                Icons.face_retouching_off_sharp,
                color: Colors.grey,
                size: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'No Rommate Found',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ];
          }
        } else {
          children = <Widget>[
            Text('Status: ${snapshot.connectionState}'),
          ];
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahallah Friend Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationStatus>().signOut();
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                'My Roommate',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: getMyRoommateList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
