import 'package:flutter/material.dart';

import '../member_profile.dart';

class RommateInformation extends StatefulWidget {
  const RommateInformation({super.key, required this.memInfo});
  final MemberProfile memInfo;
  @override
  State<RommateInformation> createState() => _RommateInformationState();
}

class _RommateInformationState extends State<RommateInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahallah Friend Finder'),
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
                'My Roommate Information',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Name:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userName!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Email:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userEmail,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Phone:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userPhone!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Gender:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userGender!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Matric Number:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userMatricNum.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Room Number:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userRoomNumber.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal.shade100,
                    child: Text(
                      'Location:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.memInfo.userLocation!.longitude.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    widget.memInfo.userLocation!.latitude.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
