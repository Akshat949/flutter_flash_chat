import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flach_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  User? loginUser;
  String? messageText;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    currentUser();
  }

  void currentUser(){
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loginUser = user;
        print(loginUser!.email);
      }
    }
    catch(e){
      print(e);
    }
  }

  void messagesStream()async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: (){
                // _auth.signOut();
                // Navigator.pop(context);
                messagesStream();
              },
              icon: const Icon(Icons.close),
          ),
        ],
        title: const Text('⚡ Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _firestore.collection('messages').orderBy('time',descending: false).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                  final messages = snapshot.data!.docs.reversed;
                  List<MessageBubble>messageWidgets=[];
                  for(var message in messages){
                    final messageText = message.data() as Map;
                    var text = messageText['text'];
                    final messageSender = message.data() as Map;
                    var sander = messageSender['sender'];
                    final timetaken = message.data() as Map;
                    var messageTime = timetaken['time'] as Timestamp;

                    final currentUser = loginUser!.email;

                    final messageBubble= MessageBubble(sender: sander,text: text,isMe: currentUser==sander,time: messageTime,);
                    messageWidgets.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      children: messageWidgets,
                    ),
                  );
              },
            ),
            Container(
              decoration: messageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        controller: messageTextController,
                        onChanged: (value){
                          messageText = value;
                        },
                        decoration:  messageTextFieldDecoration,
                      ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text':messageText,
                          'sender':loginUser!.email,
                          'time':FieldValue.serverTimestamp(),
                        });
                      },
                      child: const Text(
                        'Send',
                        style: sendButtonTextStyle,
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
class MessageBubble extends StatelessWidget {

   final String? sender;
   final String? text;
   final bool? isMe;
   final Timestamp? time;

  const MessageBubble({this.text,this.sender,this.isMe,this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe!? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children:[
          Text(
              sender!,
            style: TextStyle(
              fontSize: 12.0,

            ),
          ),
          Material(
            elevation: 6.0,
            borderRadius: isMe!? BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)) : BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            color:isMe!? Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
                text!,
                  style: TextStyle(
                    color: isMe!?Colors.white:Colors.black54,
                    fontSize: 15.0
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
}

