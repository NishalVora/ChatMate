import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final String imageUrl;
  final Key key;

  MessageBubble(this.message, this.isMe, this.userName, this.imageUrl,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
              // color: Theme.of(context).accentColor,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Column(
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: !isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                color: isMe
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Positioned(
          left: isMe ? null : 120,
          top: 0,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}
