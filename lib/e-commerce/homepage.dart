import 'package:flutter/material.dart';
import 'package:my_app/e-commerce/category_products.dart';
import 'package:my_app/e-commerce/drawerweb.dart';
import 'package:my_app/e-commerce/webservice.dart';
import 'package:my_app/model/deatilspage.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePageMain extends StatefulWidget {
  @override
  State<HomePageMain> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 14, 16, 68),
        title: Text(
          "E COMMERCE",
          style: TextStyle(
            color: Color.fromARGB(255, 239, 240, 242),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 14, 16, 68),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("length ==" + snapshot.data!.length.toString());
                    return Container(
                      height: 88,
                      color: Color.fromARGB(147, 255, 255, 255),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                print("clicked");
                                print(snapshot.data![index].category!);
                                // Uncomment the code below if needed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Category_productsPage(
                                        catid: snapshot.data![index].id!,
                                        catname:
                                            snapshot.data![index].category!,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 179, 179, 179),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category!,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 14, 16, 68),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Offer Products",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 14, 16, 68),
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                  future: Webservice().fetchProducts(),
                  builder: (context, snapshot) {
                    print(
                        "product length ==" + snapshot.data!.length.toString());
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.amber,
                        child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            itemCount:
                                //  14,
                                snapshot.data!.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final procduct = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  print("clicked");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsPage(
                                          id: procduct.id!,
                                          name: procduct.productname!,
                                          image: Webservice().imageUrl +
                                              procduct.image!,
                                          price: procduct.price.toString(),
                                          description: procduct.description!);
                                    },
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 100, maxHeight: 200),
                                            child: Image(
                                                image: NetworkImage(
                                              Webservice().imageUrl +
                                                  procduct.image!,
                                            )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  procduct.productname!,
                                                  //  "Shoes ssssssssssssssssssssssssssssssss",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rs. ' +
                                                      procduct.price.toString(),
                                                  //  "2000",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1)),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
