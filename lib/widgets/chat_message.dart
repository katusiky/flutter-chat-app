import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.texto,
    required this.uid,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child:
              uid == authService.usuario?.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff4d9ef6),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 5,
        ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 50,
        ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
