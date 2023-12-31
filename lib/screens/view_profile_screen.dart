
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:frenzygram/helper/my_date_util.dart';
import 'package:frenzygram/models/chat_user.dart';

import '../main.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ViewProfileScreen> {

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Joined on:  ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 15),),
                  Text(MyDateUtil.getLastMessageTime(context: context, time: widget.user.createdAt,showYear: true),
                      style: const TextStyle(color: Colors.black54, fontSize: 15)),
                ],
              ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                width: mq.width,
                height: mq.height * .05,
              ),
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
              SizedBox(
                height: mq.height * .03,
              ),
              Text(widget.user.email,
                  style: const TextStyle(color: Colors.black87, fontSize: 16)),
                  SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("About: ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16),),
                  Text(widget.user.about,
                      style: const TextStyle(color: Colors.black54, fontSize: 16)),
                ],
              ),
            ]
            ),
          ),
        ),
      ),
    );
  }
}
