import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:my_app/model/categorymodel.dart';
import 'package:my_app/model/ordermodel.dart';
import 'package:my_app/model/productsmodel.dart';
import 'package:my_app/model/usermodel.dart';

class Webservice {
  final imageUrl = 'http://bootcamp.cyralearnings.com/products/';
  static final mainUrl = 'http://bootcamp.cyralearnings.com/';

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse(mainUrl + 'view_offerproducts.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(int catId) async {
    print("catId==" + catId.toString());
    final response = await http.post(
      Uri.parse(mainUrl + 'get category products.php'),
      body: {'catid': catId.toString()},
    );
    print("statusCode==" + response.statusCode.toString());

    if (response.statusCode == 200) {
      print("response == " + response.body.toString());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<OrderModel>> fetchOrderDetails(String username) async {
    try {
      print("username== " + username.toString());
      final response = await http.post(
        Uri.parse(mainUrl + 'get_orderdetails.php'),
        body: {'username': username.toString()},
      );

      if (response.statusCode == 200) {
        print("response == " + response.body.toString());
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      print("order details==" + e.toString());
      rethrow; // Re-throw the exception after logging
    }
  }

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final response =
          await http.post(Uri.parse(mainUrl + 'getcategories.php'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e.toString());
      rethrow; // Re-throw the exception after logging
    }
  }

  Future<List<ProductModel>> fetchCatProducts(int catid) async {
    print("catid ==" + catid.toString());
    final response = await http.post(
        Uri.parse(mainUrl + 'get_category_products.php'),
        body: {'catid': catid.toString()});
    print("statuscode==" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("response == " + response.body.toString());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }

  Future<UserModel?> fetchUser(String username) async {
    try {
      final response = await http.post(Uri.parse(mainUrl + 'get_user.php'),
          body: {'username': username});

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
