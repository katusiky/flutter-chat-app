import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subTitulo) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(subTitulo),
        actions: [
          MaterialButton(
            child: const Text('Ok'),
            elevation: 5,
            color: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subTitulo),
      actions: [
        CupertinoDialogAction(
          child: const Text('Ok'),
          onPressed: () => Navigator.pop(context),
          isDefaultAction: true,
        ),
      ],
    ),
  );
}
