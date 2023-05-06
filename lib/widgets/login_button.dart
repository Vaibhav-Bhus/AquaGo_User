import 'package:flutter/material.dart';

customButton(context, String txt, var page) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 276,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(colors: [
              Color(0xFF283855),
              Color(0xFF2E3F68),
              Color(0xFF3B5197)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Text(txt.toString(),
            style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
