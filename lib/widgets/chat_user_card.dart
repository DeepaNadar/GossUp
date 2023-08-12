import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frenzygram/api/api.dart';
import 'package:frenzygram/helper/my_date_util.dart';
import 'package:frenzygram/models/chat_user.dart';
import 'package:frenzygram/models/message.dart';
import 'package:frenzygram/widgets/dialogs/profile_dialog.dart';

import '../main.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .02, vertical: 4),
      // color: Color.fromARGB(255, 234, 202, 216),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson( e.data() as Map<String, dynamic>)).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                leading: InkWell(
                  onTap:(){
                      showDialog(context: context, builder: (_) => ProfileDialog(user: widget.user,));
                    },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .3),
                    child: CachedNetworkImage(
                      width: mq.height * .075,
                      height: mq.height * .075,
                      imageUrl: widget.user.image,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const CircleAvatar(child: Icon(Icons.person)),
                    ),
                  ),
                ),
                title: Text(widget.user.name),

                subtitle: Text(
                  _message != null ? 
                  _message!.type==Type.image ?
                  "Image" 
                  :
                  _message!.msg 
                  : widget.user.about,
                  maxLines: 1,
                ),
                trailing: _message==null ? null
                :
                _message!.read.isEmpty && _message!.formid !=APIs.user.uid 
                ?
                 Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade400,
                      borderRadius: BorderRadius.circular(10)),
                ) :Text(
                  MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
                  style:const TextStyle(color: Colors.black54)
                  ),
                // trailing: Text("12:00 PM"),
              );
            },
          )),
    );
  }
}
