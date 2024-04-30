

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:my_app/e-commerce/homepage.dart';
import 'package:my_app/model/cart_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String description;
  final int id;

  DetailsPage({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    print("id = " + id.toString());
    print("name = " + name);
    print("price = " + price);
    print("desc = " + description);
    print("image = " + image);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePageMain();
                            },
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 240, 241),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Rs.  ' + price,
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        description,
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print("price == ${double.parse(price)}");

              var existingItemCart = context
                  .read<Cart>()
                  .getItems
                  .firstWhereOrNull((element) => element.id == id);
              if (existingItemCart != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    content: Text(
                      "This item already in cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                context
                    .read<Cart>()
                    .addItem(id, name, double.parse(price), 1, image);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    content: Text(
                      "Added to cart !!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
