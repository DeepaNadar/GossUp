import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frenzygram/main.dart';
import 'package:frenzygram/models/chat_user.dart';
import 'package:frenzygram/screens/view_profile_screen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: mq.width*.6,
        height: mq.height*.45,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .25),
                  child: CachedNetworkImage(
                    width: mq.width * .5,
                    fit: BoxFit.cover,
                    imageUrl: user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(Icons.person)),
                  ),
                ),
            ),

            Positioned(
              left: mq.width*.04,
              top: mq.height*.02,
              width: mq.width*.55,
              child: Text
              (user.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              )
              ),
            
            Positioned(
              right: 8,
              top: 6,
              child: MaterialButton(
                shape: const CircleBorder(),
                minWidth: 0,
                padding: const EdgeInsets.all(0),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ViewProfileScreen(user: user,)));
                },
                child: const Icon(
                Icons.info_outline_rounded,
                color: Color.fromARGB(255, 0, 126, 252),size: 30,),
                )
                )
          ],
        ),
        ),
      );
  }
}