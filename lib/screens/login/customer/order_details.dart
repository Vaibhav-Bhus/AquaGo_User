import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final passedInfo;
  // var screenwidth;
  const OrderDetails({super.key, this.passedInfo});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            weight: 700,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Order ${widget.passedInfo.orderId}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Date",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  widget.passedInfo.dateToDeliver.substring(0, 11),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order value",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "${widget.passedInfo.amt}",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Status",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  widget.passedInfo.orderStatus,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ordered from",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  widget.passedInfo.shopName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Status",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  widget.passedInfo.paymentStatus,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
