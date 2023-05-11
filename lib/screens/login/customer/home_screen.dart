import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/daily_record.dart';
import 'package:majorpor/screens/login/customer/orders.dart';
import 'package:majorpor/screens/login/customer/shop_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget get bottomNavigationBar {
    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(6.0),
        child: BottomNavigationBar(
          
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Shop',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              label: 'Daily',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Order',
              backgroundColor: Colors.purple,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF576CD6),
          onTap: (int index) {
            setState(
              () {
                _selectedIndex = index;
              },
            );
          },
        ),
      ),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const ShopList();
      case 1:
        return const DailyRecord();
      case 2:
        return const Orders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      bottomNavigationBar: bottomNavigationBar,
      body: _getDrawerItemWidget(_selectedIndex), //New
    );
  }
}
