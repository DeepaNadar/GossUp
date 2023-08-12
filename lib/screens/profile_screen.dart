import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzygram/models/chat_user.dart';

import 'package:frenzygram/screens/auth/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../helper/dialogs.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            label: const Text("Logout"),
            onPressed: () async {
              Dialogs.showProgressBar(context);
              await APIs.updateActiveStatus(false);
              _handleSignOut();
            },
            icon: const Icon(Icons.logout_rounded),
            backgroundColor: const Color.fromARGB(255, 152, 61, 89),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .05,
                ),
                Stack(
                  children: [
                    _image != null ? 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: Image.file(
                        File(_image!),
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.cover,
                      ),
                    )
                    :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.cover,
                        imageUrl: widget.user.image,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(child: Icon(Icons.person)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -20,
                      child: MaterialButton(
                        elevation: 1.5,
                        shape: const CircleBorder(),
                        onPressed: () {
                          _showBottomSheet();
                        },
                        color: Colors.white,
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 98, 57, 76),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                Text(widget.user.email,
                    style: const TextStyle(color: Colors.black54, fontSize: 16)),
                SizedBox(
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.name,
                  onSaved: (val) => APIs.me.name = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Enter your name",
                      label: const Text("Name")),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.about,
                  onSaved: (val) => APIs.me.about = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.info_outline_rounded),
                      hintText: "eg. I feel good.",
                      label: const Text("About")),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackBar(
                              context, "Profile updated successfully👍");
                        });
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 202, 109, 133),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignOut() async {
    try {
      await APIs.auth.signOut().then((value) async {
        await _googleSignIn.signOut().then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
          APIs.auth=FirebaseAuth.instance;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        });
      });
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              const Text(
                "Pick profile picture.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: mq.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .25, mq.height * .15)),
                      onPressed: () async {
                       final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                            if(image!=null){
                              log('Image Path: ${image.path} --MimeType: ${image.mimeType}}');
                              setState(() {
                                _image=image.path;
                              });
                              APIs.updateProfilePicture(File(_image!));
                              Navigator.pop(context);
                            }
                      },
                      child: Image.asset('images/add_image.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .25, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                            if(image!=null){
                              log('Image Path: ${image.path}');
                              setState(() {
                                _image=image.path;
                              });
                              APIs.updateProfilePicture(File(_image!));
                              Navigator.pop(context);
                            }
                      },
                      child: Image.asset('images/camera.png'))
                ],
              )
            ],
          );
        });
  }
  
}
