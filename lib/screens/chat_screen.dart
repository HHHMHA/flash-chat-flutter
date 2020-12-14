import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

import '../firebase_constants.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController()
  final _auth = FirebaseAuth.instance;
  String messageText;

  @override
  void initState() {
    super.initState();

    initLoggedInUser();
  }

  void initLoggedInUser() {
    try {
      final user = _auth.currentUser;
      if ( user != null )
        loggedInUser = user;
    } on Exception catch (e) {
      print( e );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Navigator.pop( context );
                } on Exception catch (e) {
                  print( e );
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection(Collections.messages).add({
                        "text": messageText,
                        "sender": loggedInUser.email,
                      });
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(Collections.messages).snapshots(),
      builder: (context, snapshot) {
        if ( !snapshot.hasData )
          return Center(
            child: CircularProgressIndicator(),
          );
        final messages = snapshot.data.docs.reversed;

        List<MessageBubble> messageBubbles = [];
        for ( var message in messages ) {
          final messageText = message.data["text"];
          final messageSender = message.data["sender"];

          final messageBubble = MessageBubble( sender: messageSender, text: messageText, isUserSender: messageSender == loggedInUser.email, );
          messageBubbles.add( messageBubble );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 20.0 ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

