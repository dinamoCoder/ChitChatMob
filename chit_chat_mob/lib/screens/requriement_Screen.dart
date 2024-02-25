import 'package:chit_chat_mob/screens/requirement_AdderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RequirementScreen extends StatefulWidget {
  const RequirementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreen();
}

class Message {
  final String senderName;
  final String lastMessage;
  final String imageUrl;

  Message({
    required this.senderName,
    required this.lastMessage,
    required this.imageUrl,
  });
}

class _ChatScreen extends State<RequirementScreen> {
  final List<Message> messages = [
    Message(
      senderName: "John Doe",
      lastMessage: "Hello, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    ),
    Message(
      senderName: "John Doe",
      lastMessage: "Hellosss, how are you?",
      imageUrl: "https://example.com/john_doe.jpg",
    )
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black26,
        child: Stack(
          children: [
            ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessageCard(messages[index]);
              },
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  // here we will navigate the user to the RequirementAddScreen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequirementAddScreen()));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }

  Widget buildMessageCard(Message message) {
    return Card(
      margin: const EdgeInsets.only(top: 8.5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(message.imageUrl),
        ),
        title: Text(message.senderName),
        subtitle: Text(message.lastMessage),
        onTap: () {
          // Handle tapping on a message
          print('Tapped on ${message.senderName}');
        },
      ),
    );
  }
}
