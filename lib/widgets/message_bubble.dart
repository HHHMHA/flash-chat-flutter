import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isUserSender;

  final MessageBubbleStyle _messageBubbleStyle;

  MessageBubble({this.sender, this.text, this.isUserSender}) : _messageBubbleStyle = isUserSender ? kSenderMessageBubbleStyle : kReceiverMessageBubbleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: _messageBubbleStyle.crossAxisAlignment,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: _messageBubbleStyle.borderRadius,
            elevation: 5.0,
            color: _messageBubbleStyle.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: _messageBubbleStyle.textColor,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubbleStyle {
  final Color backgroundColor;
  final Color textColor;
  final CrossAxisAlignment crossAxisAlignment;
  final BorderRadius borderRadius;

  MessageBubbleStyle({this.backgroundColor, this.textColor, this.crossAxisAlignment, this.borderRadius});
}
