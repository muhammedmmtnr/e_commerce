// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/e-commerce/cartpage.dart';
import 'package:my_app/e-commerce/homepage.dart';
import 'package:my_app/e-commerce/login.dart';
import 'package:my_app/e-commerce/orderdetails.dart';
import 'package:my_app/model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 14, 16, 68)),
            child: Text(
              'E-COMMERCE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePageMain()),
              );
              // Navigate to home page or perform the desired action
            },
          ),
          ListTile(
            leading: badges.Badge(
                showBadge:
                    //  true,
                    context.read<Cart>().getItems.isEmpty ? false : true,
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                badgeColor: Colors.red,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                )),
            title: Text('Cart Page'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPageMain()),
              );
              // Navigate to cart page or perform the desired action
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Order Details'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderdetailsPage()),
              );
              // Navigate to order details page or perform the desired action
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("isLoggedIn", false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPageMain()),
                // Perform the logout action
              );
            },
          ),
        ],
      ),
    );
  }
}
