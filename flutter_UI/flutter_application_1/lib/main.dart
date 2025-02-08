import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _user = types.User(id: "user");
  final _bot = types.User(id: "bot");

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    _sendMessageToAgent(message.text);
  }

  Future<void> _sendMessageToAgent(String text) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_input": text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final botMessage = types.TextMessage(
        author: _bot,
        id: const Uuid().v4(),
        text: data["response"],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GenAI Chat BOT"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chat(
                messages: _messages,
                onSendPressed: _handleSendPressed,
                user: _user,
                theme: DefaultChatTheme(
                  inputBackgroundColor: Colors.blueGrey[900]!,
                  inputTextColor: Colors.white,
                  sendButtonIcon: Icon(Icons.send, color: Colors.white),
                  primaryColor: Colors.blueAccent,
                  backgroundColor: Colors.black,
                  userAvatarNameColors: [Colors.blueAccent],
                  secondaryColor: Colors.grey[800]!,
                  messageBorderRadius: 16.0,
                  inputBorderRadius: BorderRadius.circular(32),
                  inputPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adjusted input field padding
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Powered by GenAI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
