import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/localization/language/languages.dart';
import 'package:flutter_travelapp/models/message.dart';
import 'package:flutter_travelapp/providers/chat_provider.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:flutter_travelapp/services/socket.dart';
import 'package:flutter_travelapp/services/socket_emit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chatscreen";
  final String id;
  final String name;
  final String image;

  ChatScreen({required this.id, required this.name, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String message = "";

  @override
  void initState() {
    super.initState();
    // connectAndListen();
    // messageAdminController.initialMessage(widget.id);
    // messageAdminController.getListMessage(widget.id);
    chatProvider.initialMessage(widget.id);
    chatProvider.getListMessage(widget.id);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          chatProvider.getListMessage(widget.id);
        }
      }
    });
  }

  _ChatDetailBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      // DateFormat("dd-MM-yyyy HH:mm:ss")
                      DateFormat("HH:mm dd-MM")
                          .format(message.createdAt.toLocal())
                          .toString(),

                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            Provider.of<UserProvider>(context).user.avatar),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 236, 236),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat("HH:mm dd-MM")
                          .format(message.createdAt.toLocal())
                          .toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: msgController,
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                  hintText:  Languages.of(context)!.enterMessageText+"...",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: IconButton(
                    color: kPrimaryColor,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (message.trim().length > 0) {
                        SocketEmit().sendMessage(message);
                        setState(() {
                          message = '';
                          msgController.text = '';
                        });
                      }
                    },
                  )),
              // textCapitalization: TextCapitalization.sentences,
              onChanged: (mes) {
                setState(() {
                  message = mes.trim();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late String prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: Languages.of(context)!.messageText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    )),
                TextSpan(text: '\n'),
                TextSpan(
                  text: 'Online',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black54,
              onPressed: () {
                chatProvider.leaveChannel(idRoom: widget.id);
                Navigator.pop(context);
              })),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: chatProvider.listMessage,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    padding: EdgeInsets.all(15.sp),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final Message message = messages[index];
                      Message message = Message.fromMap(snapshot.data[index]);
                      final bool isMe =
                          message.creatorUser == userProvider.user.id;
                      bool isSameUser = isMe == message.creatorUser;

                      prevUserId = message.creatorUser;
                      return _ChatDetailBubble(message, isMe, isSameUser);
                    },
                  );
                }),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chatProvider.leaveChannel(idRoom: widget.id);
    super.dispose();
  }
}
