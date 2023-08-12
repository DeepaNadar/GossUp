import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frenzygram/helper/my_date_util.dart';
import 'package:frenzygram/models/chat_user.dart';
import 'package:frenzygram/models/message.dart';
import 'package:frenzygram/screens/view_profile_screen.dart';
import 'package:frenzygram/widgets/message_card.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../main.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];
  final _textController = TextEditingController();
  bool _showEmoji = false, _isUploading=false;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: (){
          if(_showEmoji){
            setState(() {
              _showEmoji=!_showEmoji;

            });
            return Future.value(false);
          }else{
            return Future.value(true);
          }
        },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),
            backgroundColor: const Color.fromARGB(255, 243, 234, 238),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllMessages(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();
            
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];
            
                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                reverse: true,
                                  itemCount: _list.length,
                                  padding: EdgeInsets.only(top: mq.height * .02),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(message: _list[index]);
                                  });
                            } else {
                              return const Center(
                                  child: Text(
                                "Say Hiii...😊",
                                style: TextStyle(fontSize: 20),
                              ));
                            }
                        }
                      }),
                ),
                if(_isUploading )
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  ),


                _chatInput(),
                if(_showEmoji)
                SizedBox(
                  height: mq.height*.3,
                  child: EmojiPicker(
                    textEditingController: _textController,
                    config: Config(
                      bgColor: Colors.black87,
                      columns: 8,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewProfileScreen(user: widget.user,)));
      },
      child: StreamBuilder(stream:APIs.getUserInfo(widget.user) ,builder: (context,snapshot){
        final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson( e.data())).toList() ?? [];
return Row(
        children: [
          IconButton.filled(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white70,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              width: mq.height * .06,
              height: mq.height * .06,
              imageUrl: list.isNotEmpty ? list[0].image:widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          SizedBox(
            width: mq.width * .035,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                list.isNotEmpty ? list[0].name: widget.user.name,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .005,
              ),
              Text(
                list.isNotEmpty ? 
                list[0].isOnline ? 'Online'
                :MyDateUtil.getLastActiveTime(context: context, lastActive: list[0].lastActive)
                :MyDateUtil.getLastActiveTime(context: context, lastActive  : widget.user.lastActive),
                style: const TextStyle(fontSize: 13, color: Colors.white70),
              )
            ],
          )
        ],
      );
    
      })
      );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  IconButton.filled(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: Color.fromARGB(255, 98, 57, 76), size: 25)),
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: (){
                      if(_showEmoji)
                      setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: "Message",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  )),
                  IconButton.filled(
                      onPressed: () async {
                         final ImagePicker picker = ImagePicker();
                        final List<XFile> images =await picker.pickMultiImage(imageQuality: 80);
                          for (var i in images) {
                            log('Image Path: ${i.path}');
                            setState(() => _isUploading =true);
                            await APIs.sendChatImage(widget.user,File(i.path));
                            setState(() => _isUploading =false);
                          }
                      },
                      icon: const Icon(
                        Icons.image_rounded,
                        color: Color.fromARGB(255, 98, 57, 76),
                        size: 26,
                      )),
                  IconButton(
                      onPressed: () async {
                         final ImagePicker picker = ImagePicker();
                        final XFile? image =await picker.pickImage(
                          source: ImageSource.camera,imageQuality: 80);
                            if(image!=null){
                              log('Image Path: ${image.path}');
                              setState(() => _isUploading =true);
                              await APIs.sendChatImage(widget.user,File(image.path));
                              setState(() => _isUploading =false);
                            } 
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Color.fromARGB(255, 98, 57, 76),
                        size: 26,
                      )),
                  SizedBox(
                    width: mq.width * .02,
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text,Type.text);
                _textController.text = '';
              }
            },
            shape: const CircleBorder(),
            color: const Color.fromARGB(255, 98, 57, 76),
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
