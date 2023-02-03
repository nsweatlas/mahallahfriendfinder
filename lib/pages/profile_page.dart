import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';

import '../firebase_settings.dart';
import '../member_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String title});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

enum Gender { male, female }

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final userRoomNumberController = TextEditingController();
  final userMatricNumController = TextEditingController();
  final userLongitudeController = TextEditingController();
  final userLatitudeController = TextEditingController();
  final userPhoneController = TextEditingController();

  Gender? userGenderController = Gender.male;

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  getLoaction() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  Future<void> handleSaveMemberProfile() async {
    String userId = user!.uid;
    bool isComplete = true;

    await membersProfileRef
        .doc(userId)
        .set(
          MemberProfile(
            userId: userId,
            userEmail: user!.email.toString(),
            isComplete: isComplete,
            userName: userNameController.text,
            userRoomNumber: int.parse(userRoomNumberController.text),
            userMatricNum: int.parse(userMatricNumController.text),
            userPhone: userPhoneController.text,
            userGender:
                (userGenderController == Gender.male) ? 'Male' : 'Female',
            userLocation: GeoPoint(double.parse(userLatitudeController.text),
                double.parse(userLongitudeController.text)),
          ),
        )
        .then((value) async {
      await user?.updateDisplayName(userNameController.text);
    });
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
              context.read<Auth>().signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Please Fill Your Profile',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: userNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Your Name",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none, color: Colors.black),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (String? value) {
                            return (value!.isEmpty)
                                ? '* Required Feild!'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Gender'),
                            SizedBox(
                              width: 150,
                              child: ListTile(
                                title: const Text('Male'),
                                leading: Radio<Gender>(
                                  value: Gender.male,
                                  groupValue: userGenderController,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      userGenderController = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: ListTile(
                                title: const Text('Female'),
                                leading: Radio<Gender>(
                                  value: Gender.female,
                                  groupValue: userGenderController,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      userGenderController = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: userPhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "Your Phone",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none, color: Colors.black),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (String? value) {
                            return (value!.isEmpty)
                                ? '* Required Feild!'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: userMatricNumController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Matric Number",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none, color: Colors.black),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (String? value) {
                            return (value!.isEmpty)
                                ? '* Required Feild!'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: userRoomNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Room Number",
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none, color: Colors.black),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (String? value) {
                            return (value!.isEmpty)
                                ? '* Required Feild!'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    controller: userLongitudeController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Longitude",
                                      filled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.none,
                                            color: Colors.black),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSaved: (String? value) {},
                                    validator: (String? value) {
                                      return (value!.isEmpty)
                                          ? '* Required Feild!'
                                          : null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    controller: userLatitudeController,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Latitude",
                                      filled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.none,
                                            color: Colors.black),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSaved: (String? value) {},
                                    validator: (String? value) {
                                      return (value!.isEmpty)
                                          ? 'Required Feild!'
                                          : null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Ink(
                              decoration: ShapeDecoration(
                                color: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.location_pin,
                                  size: 20.0,
                                ),
                                color: Colors.white,
                                onPressed: () async {
                                  _locationData = await getLoaction();
                                  userLongitudeController.text =
                                      _locationData.longitude.toString();
                                  userLatitudeController.text =
                                      _locationData.latitude.toString();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 15, 100, 15),
                              backgroundColor: Colors.teal,
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                handleSaveMemberProfile();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
