import 'package:flutter/material.dart';

class PastOrderDetails extends StatefulWidget {
  final passedInfo;
  const PastOrderDetails({super.key, this.passedInfo});

  @override
  State<PastOrderDetails> createState() => _PastOrderDetailsState();
}

class _PastOrderDetailsState extends State<PastOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.passedInfo['Date']),
      ),
      body: Center(
          child: Column(
        children: [
          ListTile(
            title: Text('Type of Jar'),
            trailing: Text('Quantity'),
          ),
          ListTile(
            title: const Text("Chilled Jar"),
            trailing: Text(widget.passedInfo['ChilledJar']),
          ),
          ListTile(
            title: const Text("Normal Jar"),
            trailing: Text(widget.passedInfo['NormalJar']),
          ),
          ListTile(
            title: const Text("Normal Bottle"),
            trailing: Text(widget.passedInfo['NarmalBottle']),
          ),
          ListTile(
            title: const Text("Chilled Bottle"),
            trailing: Text(widget.passedInfo['chilledBottle']),
          ),
          
        ],
      )),
    );
  }
}
